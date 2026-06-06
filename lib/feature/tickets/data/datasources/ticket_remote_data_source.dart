import 'package:injectable/injectable.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/tickets/data/models/ticket_model.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>> getMyTickets();
  Future<TicketQrModel> getMyTicketQR({required String ticketId});
}

@LazySingleton(as: TicketRemoteDataSource)
class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  const TicketRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<TicketModel>> getMyTickets() async {
    final response = await _apiClient.get<dynamic>(ApiEndpoints.myTickets);

    final list = _extractList(response.data);
    return list
        .whereType<Map<String, dynamic>>()
        .map(TicketModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<TicketQrModel> getMyTicketQR({required String ticketId}) async {
    final res = await _apiClient.get<dynamic>(
      ApiEndpoints.ticketQr,
      queryParameters: <String, dynamic>{'id': ticketId},
    );
    return TicketQrModel.fromJson(_extractMap(res.data));
  }

  List<dynamic> _extractList(final dynamic body) {
    if (body is Map<String, dynamic> && body['data'] is List) {
      return body['data'] as List<dynamic>;
    }
    throw const JsonParsingException(
      message: 'Unexpected response shape for tickets-mine',
    );
  }

  Map<String, dynamic> _extractMap(final dynamic body) {
    if (body is Map<String, dynamic>) {
      final inner = body['data'];
      if (inner is Map<String, dynamic>) return inner;
      if (inner is Map) return Map<String, dynamic>.from(inner);
    }
    throw const JsonParsingException(
      message: 'Unexpected response shape for tickets-qr',
    );
  }
}
