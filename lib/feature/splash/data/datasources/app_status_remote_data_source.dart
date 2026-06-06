// ==============================================================================
// lib/feature/splash/data/datasources/app_status_remote_data_source.dart
// Calls the backend /health Edge Function. Returns a parsed status so the
// use case can decide between proceeding and showing maintenance.
// ==============================================================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';

/// The health information the splash cares about.
class AppHealth {
  const AppHealth({
    required this.ok,
    required this.maintenance,
    this.version,
    this.minAppVersion,
  });

  final bool ok;
  final bool maintenance;
  final String? version;
  final String? minAppVersion;
}

abstract class AppStatusRemoteDataSource {
  /// Pings the backend. Throws on a non-200 or network failure.
  Future<AppHealth> checkAppStatus();
}

@LazySingleton(as: AppStatusRemoteDataSource)
class AppStatusRemoteDataSourceImpl implements AppStatusRemoteDataSource {
  AppStatusRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<AppHealth> checkAppStatus() async {
    final Response<dynamic> res = await _apiClient.get<dynamic>(
      ApiEndpoints.health,
    );
    final dynamic body = res.data;

    // The envelope returns { success, data: { status, version, ..., maintenance } }.
    // The shared EnvelopeInterceptor (if installed) already unwraps to `data`.
    // Read defensively in case either shape arrives.
    final Map<String, dynamic> data = _extractData(body);
    return AppHealth(
      ok: data['status'] == 'ok',
      maintenance: data['maintenance'] == true,
      version: data['version'] as String?,
      minAppVersion: data['min_app_version'] as String?,
    );
  }

  Map<String, dynamic> _extractData(final dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic inner = body['data'];
      if (inner is Map<String, dynamic>) return inner;
      return body;
    }
    return const <String, dynamic>{};
  }
}
