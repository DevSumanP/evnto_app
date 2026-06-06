// ==============================================================================
// lib/core/network/interceptors/connectivity_interceptor.dart
// Rejects outgoing requests when the device has no network access.
// ==============================================================================

import 'package:dio/dio.dart';

import '../../errors/exceptions.dart';
import '../network_info.dart';

/// Rejects a request right away with [NoInternetException] when the device
/// is offline. This avoids waiting for a long connection timeout on a
/// request that cannot succeed.
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._networkInfo);

  final NetworkInfo _networkInfo;

  @override
  Future<void> onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    final bool connected = await _networkInfo.isConnected;
    if (!connected) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: const NoInternetException(),
        ),
      );
      return;
    }
    handler.next(options);
  }
}
