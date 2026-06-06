import 'package:injectable/injectable.dart';
import 'package:tap_app/core/constants/api_constants.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/home/data/models/event_model.dart';

abstract class ExploreRemoteDataSource {
  /// One page of /events-search results, with the total mathc count.
  Future<({List<EventModel> events, int total})> search(
    Map<String, dynamic> query,
  );

  /// /events-nearby results (no total — backend returns a plain list).
  Future<List<EventModel>> nearby(Map<String, dynamic> query);
}

@LazySingleton(as: ExploreRemoteDataSource)
class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  const ExploreRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<EventModel>> nearby(Map<String, dynamic> query) async {
    final response = await _apiClient.get(
      ApiEndpoints.eventsNearby,
      queryParameters: query,
    );
    return _parseEvents(response.data);
  }

  @override
  Future<({List<EventModel> events, int total})> search(
    Map<String, dynamic> query,
  ) async {
    final response = await _apiClient.get(
      ApiConstants.eventsSearch,
      queryParameters: query,
    );

    final dynamic body = response.data;
    final List<EventModel> events = _parseEvents(body);

    return (
      events: events,
      total: _extractTotal(body, fallback: events.length),
    );
  }

  List<EventModel> _parseEvents(final dynamic body) => _extractList(body)
      .whereType<Map<String, dynamic>>()
      .map(EventModel.fromJson)
      .where((m) => m.id.isNotEmpty && m.title.isNotEmpty)
      .toList(growable: false);

  List<dynamic> _extractList(final dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic inner = body['data'];
      if (inner is List) return inner;
    }
    if (body is List) return body;
    throw const JsonParsingException(
      message: 'Unexpected response shape for events search',
    );
  }

  int _extractTotal(final dynamic body, {required final int fallback}) {
    if (body is Map<String, dynamic>) {
      final dynamic meta = body['meta'];
      if (meta is Map<String, dynamic>) {
        final dynamic total = meta['total'];
        if (total is num) return total.toInt();
      }
    }
    return fallback;
  }
}
