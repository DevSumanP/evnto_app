import 'package:injectable/injectable.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/home/data/models/event_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<void> toggleFavorite({
    required String eventId,
    required bool favorite,
  });

  Future<List<EventModel>> listFavorite({int page = 1, int pageSize = 20});
}

@LazySingleton(as: FavoriteRemoteDataSource)
class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  const FavoriteRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<EventModel>> listFavorite({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _apiClient.get<dynamic>(
      ApiEndpoints.favoritesList,
      queryParameters: <String, dynamic>{'page': page, 'page_size': pageSize},
    );

    final rows = _extractList(response.data);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(EventModel.fromJson)
        .where((m) => m.id.isNotEmpty && m.title.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<void> toggleFavorite({
    required String eventId,
    required bool favorite,
  }) async {
    await _apiClient.post<dynamic>(
      ApiEndpoints.toggleFavorite,
      data: <String, dynamic>{'event_id': eventId, 'favorite': favorite},
    );
  }
}

List<dynamic> _extractList(final dynamic body) {
  if (body is Map<String, dynamic>) {
    final dynamic inner = body['data'];
    if (inner is List) return inner;
  }
  if (body is List) return body;
  throw const JsonParsingException(
    message: 'Unexpected response shape for favorites list',
  );
}
