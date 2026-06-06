// ==============================================================================
// lib/core/network/api_client.dart
// Thin wrapper around the configured Dio instance.
//
// All HTTP verbs are exposed as typed methods. Auth, retries, offline checks
// and logging are handled by interceptors that DioClient sets up. ApiClient
// just forwards the call. DioException is allowed to propagate so the
// caller's ErrorHandler can turn it into a typed Failure.
// ==============================================================================

import 'package:dio/dio.dart';

import 'dio_client.dart';

/// HTTP client used by repositories and data sources.
class ApiClient {
  ApiClient({final DioClient? dioClient})
    : _dioClient = dioClient ?? DioClient.instance;

  final DioClient _dioClient;

  /// The underlying Dio instance. Use this only when you need an API that
  /// this wrapper does not expose (for example, custom transformers).
  Dio get dio => _dioClient.dio;

  Future<Response<T>> get<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) => dio.get<T>(
    path,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onReceiveProgress: onReceiveProgress,
  );

  Future<Response<T>> post<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) => dio.post<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );

  Future<Response<T>> put<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) => dio.put<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );

  Future<Response<T>> patch<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) => dio.patch<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );

  Future<Response<T>> delete<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) => dio.delete<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  /// Multipart upload. [formData] must already include any file parts.
  Future<Response<T>> upload<T>(
    final String path, {
    required final FormData formData,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
  }) => dio.post<T>(
    path,
    data: formData,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
  );

  /// Download to [savePath]. Treat [savePath] as untrusted: validate it
  /// (no path traversal, target is writable) before calling this.
  Future<Response<dynamic>> download(
    final String urlPath,
    final dynamic savePath, {
    final ProgressCallback? onReceiveProgress,
    final Map<String, dynamic>? queryParameters,
    final CancelToken? cancelToken,
    final bool deleteOnError = true,
    final String lengthHeader = Headers.contentLengthHeader,
    final Options? options,
  }) => dio.download(
    urlPath,
    savePath,
    onReceiveProgress: onReceiveProgress,
    queryParameters: queryParameters,
    cancelToken: cancelToken,
    deleteOnError: deleteOnError,
    lengthHeader: lengthHeader,
    options: options,
  );
}
