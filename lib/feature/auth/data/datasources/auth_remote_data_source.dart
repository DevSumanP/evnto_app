// ==============================================================================
// lib/feature/auth/data/datasources/auth_remote_data_source.dart
// Talks to Supabase Auth.
//
// Hits an absolute URL (Supabase project URL) rather than the Edge Functions
// base. The auth interceptor is skipped because a stale bearer would block
// the password grant from returning a fresh one.
//
// Maps the few Supabase error shapes we care about to typed AppExceptions so
// the repository can stay generic.
// ==============================================================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/interceptors/auth_interceptor.dart';
import '../models/auth_session_model.dart';
import '../models/current_user_model.dart';

abstract class AuthRemoteDataSource {
  /// Exchange email + password for a Supabase session. Throws on failure.
  Future<AuthSessionModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<AuthSessionModel> signupWithEmail({
    required String username,
    required String email,
    required String password,
  });

  /// Revoke the current session on the server. Best-effort: throws on
  /// network errors but callers should treat these as non-fatal.
  Future<void> logout();

  /// GET /auth/v1/user. Requires a valid bearer — the auth interceptor
  /// attaches it; if expired it refreshes first.
  Future<CurrentUserModel> getCurrentUser();

  /// PUT /auth/v1/user with a new password. Requires a valid bearer (the auth
  /// interceptor attaches it). Used by the in-app "Change password" screen and
  /// by the final step of the forgot-password flow once a recovery session is
  /// in place.
  Future<void> updatePassword(String newPassword);

  /// POST /auth/v1/recover. Sends a password-reset email. With the project's
  /// "Reset Password" template set to send {{ .Token }}, the email carries a
  /// numeric OTP the user types back in. Public call — no bearer needed.
  Future<void> sendPasswordReset(String email);

  /// POST /auth/v1/verify with type=recovery. Exchanges the emailed OTP for a
  /// real session so the user can set a new password. Public call — the
  /// returned tokens are what authenticate the following [updatePassword].
  Future<AuthSessionModel> verifyRecoveryOtp({
    required String email,
    required String token,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<AuthSessionModel> loginWithEmail({
    required final String email,
    required final String password,
  }) async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.signIn}';

    try {
      final Response<dynamic> res = await _apiClient.post<dynamic>(
        url,
        queryParameters: const <String, dynamic>{'grant_type': 'password'},
        data: <String, dynamic>{'email': email.trim(), 'password': password},
        options: Options(
          // Skip the auth interceptor so a stale bearer cannot block
          // password sign-in. Force the apikey header in case the global
          // default is empty in this flavor.
          extra: const <String, dynamic>{
            AuthInterceptor.skipAuthExtraKey: true,
          },
          headers: <String, String>{
            if (AppConfig.supabaseAnonKey.isNotEmpty)
              ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
          },
        ),
      );

      final dynamic body = res.data;
      if (body is! Map<String, dynamic>) {
        throw const JsonParsingException(
          message: 'Unexpected auth response shape',
        );
      }
      return AuthSessionModel.fromJson(body);
    } on DioException catch (e, s) {
      throw _mapAuthError(e, s);
    }
  }

  /// Map Supabase auth errors to typed exceptions. The repo layer then turns
  /// these into typed Failures via the shared ErrorHandler.
  Exception _mapAuthError(final DioException e, final StackTrace s) {
    final int? status = e.response?.statusCode;
    final dynamic data = e.response?.data;
    final String? serverMessage = _readMessage(data);
    final String lowered = (serverMessage ?? '').toLowerCase();
    final String errorCode = _readErrorCode(data).toLowerCase();

    // Supabase returns 400 with "invalid_grant" / "Invalid login credentials"
    // for bad email/password — treat as InvalidCredentials, not a generic 400.
    if (status == 400 || status == 401) {
      if (lowered.contains('invalid') || lowered.contains('credentials')) {
        return InvalidCredentialsException(
          message: 'Invalid email or password.',
          details: data,
          stackTrace: s,
        );
      }
    }

    if (status == 422) {
      if (errorCode == 'user_already_exists' ||
          lowered.contains('already registered') ||
          lowered.contains('already exists')) {
        return EmailAlreadyExistsException(details: data, stackTrace: s);
      }
      if (lowered.contains('not confirmed')) {
        return EmailNotVerifiedException(
          message: 'Please verify your email before signing in.',
          details: data,
          stackTrace: s,
        );
      }
    }

    // Anything else falls through as the original DioException so the global
    // ErrorHandler can classify it (timeout / network / 5xx / etc.).
    return e;
  }

  String _readErrorCode(final dynamic data) {
    if (data is Map<String, dynamic>) {
      final Object? value = data['error_code'] ?? data['code'];
      if (value is String) return value;
    }
    return '';
  }

  String? _readMessage(final dynamic data) {
    if (data is Map<String, dynamic>) {
      final Object? value =
          data['error_description'] ??
          data['msg'] ??
          data['error'] ??
          data['message'];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }

  @override
  Future<AuthSessionModel> signupWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.signUp}';

    try {
      final Response<dynamic> res = await _apiClient.post<dynamic>(
        url,
        data: <String, dynamic>{
          'email': email,
          'password': password,
          'data': {'display_name': username},
        },
        options: Options(
          extra: const <String, dynamic>{
            AuthInterceptor.skipAuthExtraKey: true,
          },
          headers: <String, String>{
            if (AppConfig.supabaseAnonKey.isNotEmpty)
              ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
          },
        ),
      );

      final dynamic body = res.data;
      if (body is! Map<String, dynamic>) {
        throw const JsonParsingException(
          message: 'Unexpected auth response shape',
        );
      }

      return AuthSessionModel.fromJson(body);
    } on DioException catch (e, s) {
      throw _mapAuthError(e, s);
    }
  }

  @override
  Future<CurrentUserModel> getCurrentUser() async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.currentUser}';

    final Response<dynamic> res = await _apiClient.get<dynamic>(
      url,
      options: Options(
        headers: <String, String>{
          if (AppConfig.supabaseAnonKey.isNotEmpty)
            ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
        },
      ),
    );

    final dynamic body = res.data;
    if (body is! Map<String, dynamic>) {
      throw const JsonParsingException(
        message: 'Unexpected user response shape',
      );
    }
    return CurrentUserModel.fromJson(body);
  }

  @override
  Future<void> updatePassword(final String newPassword) async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.currentUser}';

    try {
      // No skipAuth here: the bearer must be attached so Supabase knows which
      // user to update.
      await _apiClient.put<dynamic>(
        url,
        data: <String, dynamic>{'password': newPassword},
        options: Options(
          headers: <String, String>{
            if (AppConfig.supabaseAnonKey.isNotEmpty)
              ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
          },
        ),
      );
    } on DioException catch (e, s) {
      throw _mapAuthError(e, s);
    }
  }

  @override
  Future<void> sendPasswordReset(final String email) async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.resetPassword}';

    try {
      await _apiClient.post<dynamic>(
        url,
        data: <String, dynamic>{'email': email.trim()},
        options: Options(
          // Public call: skip the auth interceptor so a stale bearer cannot
          // get in the way, and force the apikey header.
          extra: const <String, dynamic>{
            AuthInterceptor.skipAuthExtraKey: true,
          },
          headers: <String, String>{
            if (AppConfig.supabaseAnonKey.isNotEmpty)
              ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
          },
        ),
      );
    } on DioException catch (e, s) {
      throw _mapAuthError(e, s);
    }
  }

  @override
  Future<AuthSessionModel> verifyRecoveryOtp({
    required final String email,
    required final String token,
  }) async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.verifyOtp}';

    try {
      final Response<dynamic> res = await _apiClient.post<dynamic>(
        url,
        data: <String, dynamic>{
          'type': 'recovery',
          'email': email.trim(),
          'token': token.trim(),
        },
        options: Options(
          extra: const <String, dynamic>{
            AuthInterceptor.skipAuthExtraKey: true,
          },
          headers: <String, String>{
            if (AppConfig.supabaseAnonKey.isNotEmpty)
              ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
          },
        ),
      );

      final dynamic body = res.data;
      if (body is! Map<String, dynamic>) {
        throw const JsonParsingException(
          message: 'Unexpected verify response shape',
        );
      }
      return AuthSessionModel.fromJson(body);
    } on DioException catch (e, s) {
      throw _mapAuthError(e, s);
    }
  }

  @override
  Future<void> logout() async {
    final String url = '${AppConfig.supabaseUrl}${ApiEndpoints.signOut}';

    // Mark the call so the auth interceptor does not try to refresh on its
    // own 401 — a logout 401 just means the token was already invalid, and
    // the session service is about to clear it anyway.
    await _apiClient.post<dynamic>(
      url,
      options: Options(
        extra: const <String, dynamic>{AuthInterceptor.noRefreshExtraKey: true},
        headers: <String, String>{
          if (AppConfig.supabaseAnonKey.isNotEmpty)
            ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
        },
      ),
    );
  }
}
