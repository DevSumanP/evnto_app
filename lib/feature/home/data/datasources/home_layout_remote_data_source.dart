import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/home/domain/entities/home_signals.dart';
import 'package:tap_app/feature/home/domain/entities/user_segment.dart';

abstract class HomeLayoutRemoteDataSource {
  /// Returns the raw home-layout document (decoded JSON object).
  Future<Map<String, dynamic>> getHomeLayout(HomeSignals signals);
}

/// Live source: POSTs the signals to the `home-layout` edge function and
/// unwraps the `{ success, data: {...} }` envelope. This is the bound impl.
@LazySingleton(as: HomeLayoutRemoteDataSource)
class RemoteHomeLayoutDataSourceImpl implements HomeLayoutRemoteDataSource {
  RemoteHomeLayoutDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Map<String, dynamic>> getHomeLayout(final HomeSignals signals) async {
    final response = await _apiClient.post<dynamic>(
      ApiEndpoints.homeLayout,
      data: signals.toJson(),
    );
    return _extractLayout(response.data);
  }

  /// The envelope is `{ success, data: { schemaVersion, segment, sections } }`.
  /// Read defensively in case the shape changes.
  Map<String, dynamic> _extractLayout(final dynamic body) {
    if (body is Map) {
      final dynamic inner = body['data'];
      if (inner is Map) return Map<String, dynamic>.from(inner);
      // Tolerate a bare layout object (no envelope).
      if (body.containsKey('sections')) return Map<String, dynamic>.from(body);
    }
    throw const JsonParsingException(
      message: 'Unexpected response shape for home layout',
    );
  }
}

/// Offline / dev source: serves a bundled mock chosen by the locally-resolved
/// segment. Kept un-annotated (not registered) — swap the `@LazySingleton`
/// annotation onto this class to develop without the backend.
class AssetHomeLayoutDataSourceImpl implements HomeLayoutRemoteDataSource {
  const AssetHomeLayoutDataSourceImpl();

  @override
  Future<Map<String, dynamic>> getHomeLayout(final HomeSignals signals) async {
    final UserSegment segment = resolveSegment(
      ticketsCount: signals.ticketsCount,
      favoritesCount: signals.favoritesCount,
      activeDays: signals.activeDays,
      hasUpcomingTicket: signals.hasUpcomingTicket,
    );

    final String assetJson = 'assets/sdui/home_layout_${segment.name}.json';

    final String raw = await rootBundle.loadString(assetJson);
    final Object? decoded = json.decode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    throw const JsonParsingException(
      message: 'Home layout asset is not a JSON object',
    );
  }
}
