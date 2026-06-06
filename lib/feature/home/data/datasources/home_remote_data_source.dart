import 'package:injectable/injectable.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/home/data/models/event_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<EventModel>> getEvents({
    String? city,
    String? from,
    int pageSize = 10,
  });
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<EventModel>> getEvents({
    String? city,
    String? from,
    int pageSize = 10,
  }) async {
    final query = <String, dynamic>{'page_size': pageSize};
    if (city != null && city.isNotEmpty) query['city'] = city;
    if (from != null && from.isNotEmpty) query['from'] = from;

    final response = await _apiClient.get<dynamic>(
      ApiEndpoints.events,
      queryParameters: query,
    );

    final rows = _extractList(response.data);

    return rows
        .whereType<Map<String, dynamic>>()
        .map(EventModel.fromJson)
        .where((m) => m.title.isNotEmpty)
        .toList(growable: false);
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
      message: 'Unexpected response shape for events list',
    );
  }
}
