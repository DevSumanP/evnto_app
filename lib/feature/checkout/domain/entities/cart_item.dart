import 'package:equatable/equatable.dart';

import '../../../event-detail/domain/entities/event_detail.dart';

class CartItem extends Equatable {
  const CartItem({required this.tier, required this.quantity})
    : assert(quantity > 0, 'Cartitem cannot have zero quantity');

  final TicketTier tier;
  final int quantity;

  /// Tier price multiplied by quantity, in paisa.
  int get lineTotalPaisa => tier.pricePaisa * quantity;

  CartItem copyWith({TicketTier? tier, int? quantity}) =>
      CartItem(tier: tier ?? this.tier, quantity: quantity ?? this.quantity);

  @override
  List<Object?> get props => [tier.id, quantity];
}
