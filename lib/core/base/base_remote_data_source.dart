// ==============================================================================
// lib/core/base/base_remote_data_source.dart
// Base class for remote data sources. Exposes the configured HTTP client.
//
// Concrete data sources should throw typed AppExceptions. The mapping to
// Failure happens at the repository layer.
// ==============================================================================

import 'package:dio/dio.dart';

import '../network/api_client.dart';

/// Base class for remote data sources.
abstract class BaseRemoteDataSource {
  const BaseRemoteDataSource(this._client);

  final ApiClient _client;

  /// The underlying Dio instance. Use this only when you need something
  /// that [ApiClient] does not expose.
  Dio get dio => _client.dio;

  /// HTTP wrapper. Prefer the typed `get/post/...` methods below over
  /// reaching for [dio] directly so test seams stay consistent.
  ApiClient get client => _client;

  Future<Response<T>> get<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) => _client.get<T>(
    path,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<Response<T>> post<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) => _client.post<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<Response<T>> put<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) => _client.put<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<Response<T>> delete<T>(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) => _client.delete<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );
}
