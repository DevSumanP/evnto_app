// ==============================================================================
// lib/core/network/interceptors/auth_interceptor.dart
// Attaches the stored bearer to every outgoing request and recovers from 401
// responses by refreshing the session and retrying the original request.
// ==============================================================================

import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../errors/exceptions.dart';
import '../../services/auth_session_service.dart';
import '../../services/storage_service.dart';
import '../../utils/logger.dart';

/// Authentication interceptor.
///
/// Request side:
///   - Adds `Authorization: Bearer <token>` to every outgoing request that
///     does not already have one and has not opted out via
///     [skipAuthExtraKey].
///
/// Error side (the recovery loop):
///   1. Non-401 → pass through.
///   2. 401 on a refresh call ([noRefreshExtraKey]) → give up, mark expired,
///      pass through. This prevents an infinite refresh loop if the refresh
///      endpoint itself returns 401.
///   3. 401 on a request already retried once → same as above. Prevents an
///      infinite "refresh, retry, 401, refresh, retry, 401..." loop when the
///      server keeps rejecting the new token.
///   4. 401 with no refresh token available → mark expired, pass through.
///   5. 401 with a refresh token → ask [AuthSessionService] to refresh
///      (concurrent 401s share one in-flight refresh), then re-fire the
///      original request with the new bearer via [Dio.fetch]. If refresh
///      itself fails the session is already marked expired by the service.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required final StorageService storage,
    required final AuthSessionService session,
    required final Dio dio,
  })  : _storage = storage,
        _session = session,
        _dio = dio;

  /// Set `options.extra[AuthInterceptor.skipAuthExtraKey] = true` on a
  /// request (for example, login) to skip the bearer-token attachment.
  static const String skipAuthExtraKey = 'skip_auth';

  /// Set on the refresh-token call itself so a 401 there does not trigger
  /// another refresh attempt.
  static const String noRefreshExtraKey = 'no_refresh';

  /// Internal marker added when we have already retried a request once,
  /// so we never recurse twice on the same call.
  static const String _retriedKey = '_auth_retried';

  final StorageService _storage;
  final AuthSessionService _session;
  final Dio _dio;
  final AppLogger _logger = AppLogger.instance;

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) {
    final bool skip = options.extra[skipAuthExtraKey] == true;
    final bool alreadySet = options.headers.containsKey(
      ApiConstants.headerAuthorization,
    );

    if (!skip && !alreadySet) {
      final String? token = _storage.getAuthToken();
      if (token != null && token.isNotEmpty) {
        options.headers[ApiConstants.headerAuthorization] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    final int? status = err.response?.statusCode;
    if (status != 401) {
      handler.next(err);
      return;
    }

    final Map<String, dynamic> extra = err.requestOptions.extra;
    final bool isRefreshCall = extra[noRefreshExtraKey] == true;
    final bool alreadyRetried = extra[_retriedKey] == true;

    if (isRefreshCall || alreadyRetried) {
      _logger.warning(
        'Got 401 ${isRefreshCall ? "on refresh" : "after retry"}; '
        'giving up and clearing session.',
        category: 'Auth',
      );
      await _session.markExpired();
      handler.next(err);
      return;
    }

    if (!_session.canRefresh) {
      _logger.warning(
        'Got 401 with no refresh_token available.',
        category: 'Auth',
      );
      await _session.markExpired();
      handler.next(err);
      return;
    }

    try {
      final String newToken = await _session.refresh();
      // Rebuild the request with the fresh bearer and mark it so a second
      // 401 on the retry will not loop back here.
      err.requestOptions.headers[ApiConstants.headerAuthorization] =
          'Bearer $newToken';
      err.requestOptions.extra[_retriedKey] = true;

      final Response<dynamic> response =
          await _dio.fetch<dynamic>(err.requestOptions);
      handler.resolve(response);
    } on RefreshTokenException {
      // Service has already cleared tokens and emitted SessionExpired.
      // Bubble the original 401 to the caller.
      handler.next(err);
    } on Object catch (e, s) {
      _logger.error('Unexpected error during 401 recovery', e, s, 'Auth');
      handler.next(err);
    }
  }
}
