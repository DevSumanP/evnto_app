import 'package:injectable/injectable.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/event-detail/data/models/event_detail_model.dart';

abstract class EventDetailRemoteDataSource {
  Future<EventDetailModel> getEventDetail({required String eventId});
}

@LazySingleton(as: EventDetailRemoteDataSource)
class EventDetailRemoteDataSourceImpl implements EventDetailRemoteDataSource {
  const EventDetailRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<EventDetailModel> getEventDetail({required String eventId}) async {
    final response = await _apiClient.get<dynamic>(
      ApiEndpoints.eventDetail,
      queryParameters: <String, dynamic>{'id': eventId},
    );

    final Map<String, dynamic> row = _extractRow(response.data);
    return EventDetailModel.fromJson(row);
  }

  /// The envelope returns { success, data: {...}, request_id }. Read
  /// defensively in case the response shape changes.
  Map<String, dynamic> _extractRow(final dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic inner = body['data'];
      if (inner is Map<String, dynamic>) return inner;
      if (inner is Map) return Map<String, dynamic>.from(inner);
    }
    throw const JsonParsingException(
      message: 'Unexpected response shape for event detail',
    );
  }
}
