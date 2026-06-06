import 'package:equatable/equatable.dart';

/// One issued ticket returned from POST /checkout-verify.
class IssuedTicket extends Equatable {
  const IssuedTicket({
    required this.id,
    required this.tierId,
    required this.tierName,
    required this.serial,
    this.seatLabel,
  });

  final String id;
  final String tierId;
  final String tierName;
  final String serial; // human-readable, e.g. "TAP-000123"
  final String? seatLabel; // null for general admission

  @override
  List<Object?> get props => [id, tierId, tierName, serial, seatLabel];
}
