// ==============================================================================
// lib/core/services/auth_session_service.dart
// Owns the lifecycle of the Supabase auth session on the client.
//
//   - refresh()     : exchange the stored refresh_token for a new access_token.
//                     Concurrent callers share a single in-flight request,
//                     so a burst of 401s only triggers one refresh round-trip.
//   - signOut()     : clear local credentials and emit SignedOut.
//   - markExpired() : clear local credentials and emit Expired. Called by the
//                     auth interceptor when refresh is impossible or fails.
//   - events        : broadcast stream the UI subscribes to. A listener high
//                     in the widget tree routes to LoginRoute on either event.
//
// The refresh call deliberately uses its own short-lived Dio instance instead
// of the shared one. That avoids a dependency cycle (AuthInterceptor → this
// service → main Dio → AuthInterceptor) and side-steps the global interceptor
// chain, which would otherwise try to attach the stale bearer and recurse on
// its own 401 handling.
// ==============================================================================

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../config/app_config.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../network/api_endpoints.dart';
import '../utils/logger.dart';
import 'storage_service.dart';

/// What the session emits to the rest of the app.
sealed class SessionEvent {
  const SessionEvent();
}

/// The session is no longer valid. Refresh failed or never had a refresh
/// token to begin with. The UI should send the user back to login.
class SessionExpired extends SessionEvent {
  const SessionExpired();
}

/// The user explicitly signed out. The UI should send them to onboarding /
/// login and forget any per-session state.
class SessionSignedOut extends SessionEvent {
  const SessionSignedOut();
}

@lazySingleton
class AuthSessionService {
  AuthSessionService(this._storage);

  final StorageService _storage;
  final AppLogger _logger = AppLogger.instance;
  final StreamController<SessionEvent> _events =
      StreamController<SessionEvent>.broadcast();

  /// Holds the in-flight refresh so concurrent callers wait on one round-trip.
  Completer<String>? _refreshInFlight;

  /// Subscribe to know when the session has expired or been signed out.
  Stream<SessionEvent> get events => _events.stream;

  /// True when we have a refresh_token in storage. The interceptor checks
  /// this before attempting a refresh.
  bool get canRefresh => (_storage.getRefreshToken() ?? '').isNotEmpty;

  /// True when the stored access token has passed its expiry. Returns true
  /// when expiry is unknown so callers fall back to a refresh attempt.
  bool get isAccessTokenExpired {
    final DateTime? expiresAt = _storage.getAuthExpiresAt();
    if (expiresAt == null) return true;
    // 30-second skew protects against clock drift between client and server.
    return DateTime.now().add(const Duration(seconds: 30)).isAfter(expiresAt);
  }

  /// Exchange the stored refresh_token for a new access_token.
  /// Returns the new access token on success. Throws on failure (caller
  /// should treat any thrown error as a dead session).
  ///
  /// Concurrent calls share the same in-flight request.
  Future<String> refresh() {
    final Completer<String>? inFlight = _refreshInFlight;
    if (inFlight != null) return inFlight.future;

    final Completer<String> completer = Completer<String>();
    _refreshInFlight = completer;

    _doRefresh()
        .then(completer.complete)
        .catchError((final Object error, final StackTrace stack) {
          completer.completeError(error, stack);
        })
        .whenComplete(() => _refreshInFlight = null);

    return completer.future;
  }

  Future<String> _doRefresh() async {
    final String? refreshToken = _storage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _logger.warning(
        'Refresh attempted with no refresh_token in storage.',
        category: 'Auth',
      );
      await _clearAndEmitExpired();
      throw const RefreshTokenException();
    }

    final Dio refreshDio = Dio(
      BaseOptions(
        baseUrl: AppConfig.supabaseUrl,
        headers: <String, String>{
          if (AppConfig.supabaseAnonKey.isNotEmpty)
            ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
          ApiConstants.headerContentType: ApiConstants.contentTypeJson,
          ApiConstants.headerAccept: ApiConstants.contentTypeJson,
        },
        validateStatus: (final int? s) => s != null && s >= 200 && s < 300,
      ),
    );

    try {
      final Response<dynamic> res = await refreshDio.post<dynamic>(
        ApiEndpoints.refreshToken,
        queryParameters: const <String, dynamic>{'grant_type': 'refresh_token'},
        data: <String, dynamic>{'refresh_token': refreshToken},
      );

      final dynamic body = res.data;
      if (body is! Map<String, dynamic>) {
        throw const JsonParsingException(
          message: 'Unexpected refresh-token response shape',
        );
      }

      final String? newAccess = body['access_token'] as String?;
      final String newRefresh = (body['refresh_token'] as String?) ?? '';
      final int expiresIn = _asInt(body['expires_in']) ?? 3600;

      if (newAccess == null || newAccess.isEmpty) {
        throw const JsonParsingException(
          message: 'Refresh response missing access_token',
        );
      }

      await persistSession(
        accessToken: newAccess,
        refreshToken: newRefresh.isNotEmpty ? newRefresh : refreshToken,
        expiresIn: Duration(seconds: expiresIn),
      );

      _logger.info('Auth session refreshed.', category: 'Auth');
      return newAccess;
    } on Object catch (e, s) {
      _logger.warning(
        'Refresh failed; treating session as expired.',
        category: 'Auth',
        error: e,
      );
      await _clearAndEmitExpired();
      // Wrap dio/parse failures in our typed exception so the interceptor
      // and any other caller can pattern-match consistently.
      if (e is RefreshTokenException) rethrow;
      throw RefreshTokenException(details: e, stackTrace: s);
    } finally {
      refreshDio.close();
    }
  }

  /// Store the full session triple at once. Used by login, signup, and
  /// refresh so the expiry stays consistent with the tokens.
  Future<void> persistSession({
    required final String accessToken,
    required final String refreshToken,
    required final Duration expiresIn,
  }) async {
    await _storage.setAuthToken(accessToken);
    if (refreshToken.isNotEmpty) {
      await _storage.setRefreshToken(refreshToken);
    }
    await _storage.setAuthExpiresAt(DateTime.now().add(expiresIn));
  }

  /// Drop tokens locally and emit a signed-out event. Use after a real
  /// sign-out (e.g., user tapped the button and the server logout succeeded).
  Future<void> signOut() async {
    await _storage.clearTokens();
    await _storage.clearAuthExpiresAt();
    await _storage.clearUserLocation();
    _events.add(const SessionSignedOut());
  }

  /// Drop tokens locally and emit a session-expired event. Use when refresh
  /// fails or is impossible; the UI should send the user back to login.
  Future<void> markExpired() => _clearAndEmitExpired();

  Future<void> _clearAndEmitExpired() async {
    try {
      await _storage.clearTokens();
      await _storage.clearAuthExpiresAt();
    } on Object catch (e, s) {
      _logger.error(
        'Failed to clear tokens while marking session expired',
        e,
        s,
        'Auth',
      );
    }
    _events.add(const SessionExpired());
  }

  static int? _asInt(final Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  @disposeMethod
  void dispose() {
    _events.close();
  }
}
