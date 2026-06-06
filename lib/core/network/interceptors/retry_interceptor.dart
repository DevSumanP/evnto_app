// ==============================================================================
// lib/core/network/interceptors/retry_interceptor.dart
// Retries transient HTTP failures with exponential back-off.
// ==============================================================================

import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/logger.dart';

/// Retries requests that fail with a transient error.
///
/// What gets retried:
///   - connection and timeout errors (always)
///   - 5xx responses (only for idempotent methods)
///
/// What does not get retried:
///   - 4xx responses
///   - cancelled requests
///   - bad TLS certificate
///   - 5xx on POST / PATCH (could duplicate a non-idempotent write)
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelays = const <Duration>[
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 4),
    ],
  });

  /// Dio instance used to re-send the original request.
  final Dio dio;

  /// Maximum number of retries.
  final int maxRetries;

  /// Delay before each retry. The last entry is reused for attempts past
  /// the end of the list.
  final List<Duration> retryDelays;

  /// Key used to store the retry counter on `RequestOptions.extra`.
  static const String _retryCountKey = 'retry_count';

  /// HTTP methods that are safe to retry on a 5xx response.
  static const Set<String> _idempotentMethods = <String>{
    'GET',
    'HEAD',
    'OPTIONS',
    'PUT',
    'DELETE',
  };

  final AppLogger _logger = AppLogger.instance;

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    final RequestOptions options = err.requestOptions;
    final int attempt = (options.extra[_retryCountKey] as int?) ?? 0;

    if (!_shouldRetry(err) || attempt >= maxRetries) {
      handler.next(err);
      return;
    }

    final Duration delay = attempt < retryDelays.length
        ? retryDelays[attempt]
        : retryDelays.last;

    _logger.warning(
      'Retrying ${options.method} ${options.uri} '
      '(attempt ${attempt + 1}/$maxRetries) after ${delay.inMilliseconds}ms',
      category: 'HTTP',
    );

    await Future<void>.delayed(delay);
    options.extra[_retryCountKey] = attempt + 1;

    try {
      final Response<dynamic> response = await dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _shouldRetry(final DioException err) {
    if (err.type == DioExceptionType.cancel) return false;
    if (err.type == DioExceptionType.badCertificate) return false;

    // Connection / timeout errors are always safe to retry.
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    // 5xx is retryable only for idempotent methods.
    final int? statusCode = err.response?.statusCode;
    if (err.type == DioExceptionType.badResponse && statusCode != null) {
      if (statusCode < 500 || statusCode >= 600) return false;
      final String method = err.requestOptions.method.toUpperCase();
      return _idempotentMethods.contains(method);
    }

    return false;
  }
}
