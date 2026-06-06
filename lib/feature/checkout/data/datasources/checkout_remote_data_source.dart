import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/constants/api_constants.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/checkout/data/models/checkout_initiate_model.dart';
import 'package:tap_app/feature/checkout/data/models/checkout_verify_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutInitiateModel> initiate({
    required CheckoutInitiateRequest request,
    required String idempotencyKey,
  });

  Future<CheckoutVerifyModel> verify({
    required String orderId,
    required String pidx,
  });
}

@LazySingleton(as: CheckoutRemoteDataSource)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CheckoutInitiateModel> initiate({
    required CheckoutInitiateRequest request,
    required String idempotencyKey,
  }) async {
    final response = await _apiClient.post<dynamic>(
      ApiEndpoints.startCheckout,
      data: request.toJson(),
      options: Options(
        headers: <String, dynamic>{ApiConstants.idempotencyKey: idempotencyKey},
      ),
    );
    return CheckoutInitiateModel.fromJson(_extract(response.data));
  }

  @override
  Future<CheckoutVerifyModel> verify({
    required String orderId,
    required String pidx,
  }) async {
    final response = await _apiClient.post<dynamic>(
      ApiEndpoints.verifyCheckout,
      data: <String, dynamic>{'order_id': orderId, 'pidx': pidx},
    );
    return CheckoutVerifyModel.fromJson(_extract(response.data));
  }

  /// Envelope is { success, data, request_id } like the rest of the API.
  Map<String, dynamic> _extract(final dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic inner = body['data'];
      if (inner is Map<String, dynamic>) return inner;
      if (inner is Map) return Map<String, dynamic>.from(inner);
    }
    throw const JsonParsingException(
      message: 'Unexpected response shape for checkout',
    );
  }
}
