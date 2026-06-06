import 'package:equatable/equatable.dart';

/// Result of POST / checkout-initialte. Holds the seats for 10 minutes; after
/// [epiresAt] the order is auto-released server-side
class CheckoutSession extends Equatable {
  const CheckoutSession({
    required this.orderId,
    required this.pidx,
    required this.paymentUrl,
    required this.totalPaisa,
    required this.expiresAt,
  });

  final String orderId;
  final String pidx; // Khalti payment index — needed for verify
  final String paymentUrl; // open this in the webview
  final int totalPaisa;
  final DateTime expiresAt;

  @override
  List<Object?> get props => [orderId, pidx, paymentUrl, totalPaisa, expiresAt];
}
