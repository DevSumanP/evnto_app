import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/feature/checkout/domain/entities/checkout_session.dart';

/// Body for POST /checkout-initiate
class CheckoutInitiateRequest {
  const CheckoutInitiateRequest({
    required this.eventId,
    required this.items,
    required this.buyer,
    this.seatIds,
  });

  final String eventId;
  final List<CheckoutLineItemDto> items;
  final BuyerDto buyer;
  final List<String>? seatIds;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'event_id': eventId,
    'items': items.map((i) => i.toJson()).toList(growable: false),
    'buyer': buyer.toJson(),
    if (seatIds != null) 'seat_ids': seatIds,
  };
}

class CheckoutLineItemDto {
  const CheckoutLineItemDto({required this.tierId, required this.quantity});

  final String tierId;
  final int quantity;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tier_id': tierId,
    'quantity': quantity,
  };
}

class BuyerDto {
  const BuyerDto({required this.name, this.email, this.phone});
  final String name;
  final String? email;
  final String? phone;

  // The backend's zod schema runs min(7) on phone and email() on email even
  // when the field is "optional", so an empty string fails validation. Only
  // include each field when it has real content.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    if (email != null && email!.isNotEmpty) 'email': email,
    if (phone != null && phone!.isNotEmpty) 'phone': phone,
  };
}

/// Response of POST /checkout-initiate.
class CheckoutInitiateModel {
  const CheckoutInitiateModel({
    required this.orderId,
    required this.pidx,
    required this.paymentUrl,
    required this.totalPaisa,
    required this.expiresAt,
  });

  final String orderId;
  final String pidx;
  final String paymentUrl;
  final int totalPaisa;
  final DateTime expiresAt;

  factory CheckoutInitiateModel.fromJson(final Map<String, dynamic> json) {
    final DateTime? exp = _asDate(json['expires_at']);
    if (exp == null) {
      throw const JsonParsingException(
        message: 'checkout-initiate response missing expires_at',
      );
    }
    return CheckoutInitiateModel(
      orderId: (json['order_id'] as String?)?.trim() ?? '',
      pidx: (json['pidx'] as String?)?.trim() ?? '',
      paymentUrl: (json['payment_url'] as String?)?.trim() ?? '',
      totalPaisa: _asInt(json['total_paisa']) ?? 0,
      expiresAt: exp,
    );
  }

  CheckoutSession toEntity() => CheckoutSession(
    orderId: orderId,
    pidx: pidx,
    paymentUrl: paymentUrl,
    totalPaisa: totalPaisa,
    expiresAt: expiresAt,
  );
}

DateTime? _asDate(final Object? v) =>
    v is String && v.isNotEmpty ? DateTime.tryParse(v) : null;
int? _asInt(final Object? v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}
