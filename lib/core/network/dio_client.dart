// ==============================================================================
// lib/core/network/dio_client.dart
// Singleton wrapper around the configured Dio instance.
//
// Owns the single Dio instance and its interceptor chain. [initialize] is
// safe to call more than once: the second call is a no-op. This keeps hot
// reload from dropping in-flight requests.
// ==============================================================================

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import '../constants/api_constants.dart';
import '../constants/app_constant.dart';
import '../di/core_injection.dart';
import '../services/auth_session_service.dart';
import '../services/storage_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'network_info.dart';

/// Singleton wrapper around the configured [Dio] instance.
///
/// All HTTP configuration (timeouts, base URL, interceptors) lives here in
/// one place. Callers use [ApiClient] for the typed HTTP API.
class DioClient {
  DioClient._internal();

  static final DioClient instance = DioClient._internal();

  Dio? _dio;
  bool _initialized = false;

  /// The configured Dio instance.
  ///
  /// Throws [StateError] if accessed before [initialize]. That is a
  /// programmer error, not a runtime condition to recover from.
  Dio get dio {
    final Dio? d = _dio;
    if (d == null) {
      throw StateError('DioClient.dio accessed before initialize()');
    }
    return d;
  }

  /// Whether [initialize] has been called.
  bool get isInitialized => _initialized;

  /// Configure Dio. Safe to call more than once; later calls are no-ops.
  void initialize({
    final String? baseUrl,
    final Duration? connectTimeout,
    final Duration? sendTimeout,
    final Duration? receiveTimeout,
    final Map<String, String>? headers,
    final List<Interceptor>? additionalInterceptors,
  }) {
    if (_initialized) return;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? AppConfig.apiBaseUrl,
        connectTimeout: connectTimeout ??
            const Duration(milliseconds: AppConstants.apiConnectTimeoutMs),
        sendTimeout: sendTimeout ??
            const Duration(milliseconds: AppConstants.apiTimeoutMs),
        receiveTimeout: receiveTimeout ??
            const Duration(milliseconds: AppConstants.apiReceiveTimeoutMs),
        headers: <String, String>{
          ApiConstants.headerContentType: ApiConstants.contentTypeJson,
          ApiConstants.headerAccept: ApiConstants.contentTypeJson,
          ApiConstants.headerPlatform: _platformName(),
          ApiConstants.headerAppVersion: AppConstants.fullVersion,
          // Supabase Edge Functions reject any call without this header.
          // Safe to ship: the anon key is a public key by design.
          if (AppConfig.supabaseAnonKey.isNotEmpty)
            'apikey': AppConfig.supabaseAnonKey,
          if (headers != null) ...headers,
        },
        // Only 2xx is a success. 4xx and 5xx are reported as a
        // DioException(badResponse), which ErrorHandler turns into a
        // typed Failure.
        validateStatus: (final int? status) =>
            status != null && status >= 200 && status < 300,
        // Do not follow redirects automatically. This avoids leaking the
        // auth header to another host and forces the API layer to handle
        // redirects explicitly.
        followRedirects: false,
      ),
    );

    _setupInterceptors(additionalInterceptors);
    _initialized = true;
  }

  /// Build the interceptor chain.
  ///
  /// Order matters:
  ///   1. Request ID — adds a unique ID to every call before logging, so
  ///      client logs and server traces share the same correlation ID.
  ///   2. Logging — prints the request and response (with secrets redacted).
  ///      Only added when the env flag enables it.
  ///   3. Auth — attaches the bearer token. Clears stored tokens on 401.
  ///   4. Connectivity — rejects the request when the device is offline.
  ///   5. Retry — last, so retries use a fresh token and online check.
  void _setupInterceptors(final List<Interceptor>? additionalInterceptors) {
    final Dio client = dio;
    client.interceptors.clear();

    client.interceptors.add(_RequestIdInterceptor());
    if (AppConfig.enableLogging) {
      client.interceptors.add(LoggingInterceptor());
    }
    client.interceptors.add(
      AuthInterceptor(
        storage: inject<StorageService>(),
        session: inject<AuthSessionService>(),
        dio: client,
      ),
    );
    client.interceptors.add(ConnectivityInterceptor(NetworkInfo.instance));
    client.interceptors.add(RetryInterceptor(dio: client));

    if (additionalInterceptors != null) {
      client.interceptors.addAll(additionalInterceptors);
    }
  }

  /// Stable platform name used for the `X-Platform` header.
  String _platformName() {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }

  /// Change the base URL on the underlying Dio instance.
  void updateBaseUrl(final String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  /// Merge [headers] into the default headers used on every request.
  void updateHeaders(final Map<String, String> headers) {
    dio.options.headers.addAll(headers);
  }

  void removeHeader(final String key) {
    dio.options.headers.remove(key);
  }

  void addInterceptor(final Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  void clearInterceptors() {
    dio.interceptors.clear();
  }

  /// Close the underlying Dio instance. Call [initialize] again before use.
  void close({final bool force = false}) {
    _dio?.close(force: force);
    _dio = null;
    _initialized = false;
  }
}

/// Adds a unique `X-Request-Id` header to every request, so client logs
/// can be cross-referenced with server traces.
class _RequestIdInterceptor extends Interceptor {
  _RequestIdInterceptor();

  final Random _random = Random.secure();

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) {
    options.headers.putIfAbsent(
      ApiConstants.headerRequestId,
      _generateRequestId,
    );
    handler.next(options);
  }

  /// 16 hex characters of secure random data. Short enough to grep,
  /// long enough to avoid collisions for any normal request volume.
  String _generateRequestId() {
    const String alphabet = '0123456789abcdef';
    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < 16; i++) {
      buf.write(alphabet[_random.nextInt(alphabet.length)]);
    }
    return buf.toString();
  }
}
