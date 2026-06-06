import '../../domain/entities/issued_ticket.dart';

/// Response of POST /checkout-verify: { tickets: [ ... ] }.
class CheckoutVerifyModel {
  const CheckoutVerifyModel({required this.tickets});
  final List<IssuedTicketModel> tickets;

  factory CheckoutVerifyModel.fromJson(final Map<String, dynamic> json) {
    final Object? raw = json['tickets'];
    if (raw is! List) {
      return const CheckoutVerifyModel(tickets: <IssuedTicketModel>[]);
    }
    return CheckoutVerifyModel(
      tickets: raw
          .whereType<Map<String, dynamic>>()
          .map(IssuedTicketModel.fromJson)
          .toList(growable: false),
    );
  }

  List<IssuedTicket> toEntities() =>
      tickets.map((t) => t.toEntity()).toList(growable: false);
}

class IssuedTicketModel {
  const IssuedTicketModel({
    required this.id,
    required this.tierId,
    required this.tierName,
    required this.serial,
    this.seatLabel,
  });

  final String id;
  final String tierId;
  final String tierName;
  final String serial;
  final String? seatLabel;

  factory IssuedTicketModel.fromJson(final Map<String, dynamic> json) {
    return IssuedTicketModel(
      id: (json['id'] as String?)?.trim() ?? '',
      tierId: (json['tier_id'] as String?)?.trim() ?? '',
      tierName: (json['tier_name'] as String?)?.trim() ?? '',
      serial: (json['serial'] as String?)?.trim() ?? '',
      seatLabel: (json['seat_label'] as String?)?.trim(),
    );
  }

  IssuedTicket toEntity() => IssuedTicket(
    id: id,
    tierId: tierId,
    tierName: tierName,
    serial: serial,
    seatLabel: seatLabel,
  );
}
