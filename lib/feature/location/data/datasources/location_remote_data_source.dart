// ==============================================================================
// lib/feature/location/data/datasources/location_remote_data_source.dart
// Talks to:
//   - /locations-popular  (public list of common cities)
//   - /profile-upsert     (writes the user's chosen city/country)
// ==============================================================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/popular_location_model.dart';

abstract class LocationRemoteDataSource {
  Future<List<PopularLocationModel>> getPopularLocations({final int limit});

  Future<void> updateProfileLocation({
    required final String city,
    final String? country,
  });
}

@LazySingleton(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  LocationRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<PopularLocationModel>> getPopularLocations({
    final int limit = 10,
  }) async {
    final Response<dynamic> res = await _apiClient.get<dynamic>(
      ApiEndpoints.locationsPopular,
      queryParameters: <String, dynamic>{'limit': limit},
    );

    final List<dynamic> rows = _extractList(res.data);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(PopularLocationModel.fromJson)
        .where((final PopularLocationModel m) => m.city.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<void> updateProfileLocation({
    required final String city,
    final String? country,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{'city': city};
    if (country != null && country.isNotEmpty) {
      body['country'] = country;
    }
    await _apiClient.post<dynamic>(ApiEndpoints.profile, data: body);
  }

  /// The envelope returns { success, data: [...] }. Read defensively in case
  /// the response shape changes.
  List<dynamic> _extractList(final dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic inner = body['data'];
      if (inner is List) return inner;
    }
    if (body is List) return body;
    throw const JsonParsingException(
      message: 'Unexpected response shape for popular locations',
    );
  }
}
