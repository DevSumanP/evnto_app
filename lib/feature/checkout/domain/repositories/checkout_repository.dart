import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/checkout/data/models/checkout_initiate_model.dart';
import 'package:tap_app/feature/checkout/domain/entities/checkout_session.dart';
import 'package:tap_app/feature/checkout/domain/entities/issued_ticket.dart';

abstract class CheckoutRepository {
  /// POST /checkout-initiate. Holds seat for 10 minutes.
  /// [idempotencyKey] should be fresh uuid per user-deriven attempt.
  EitherFailure<CheckoutSession> initiate({
    required CheckoutInitiateRequest request,
    required String idempotencyKey,
  });

  /// POST /checkout-verify. call after the Khalti webview returns success
  EitherFailure<List<IssuedTicket>> verify({
    required String orderId,
    required String pidx,
  });
}
