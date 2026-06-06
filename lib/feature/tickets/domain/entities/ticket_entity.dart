import 'package:equatable/equatable.dart';

import '../../../event-detail/domain/entities/event_detail.dart';
import '../../../home/domain/entities/event_entity.dart';

class TicketEntity extends Equatable {
  final String id;
  final String status;
  final DateTime? checkedInAt;
  final DateTime createdAt;
  final TicketTier ticketTier;
  final TicketSeat? seats;
  final Event event;

  const TicketEntity({
    required this.id,
    required this.status,
    required this.checkedInAt,
    required this.createdAt,
    required this.ticketTier,
    required this.seats,
    required this.event,
  });

  bool get isCheckedIn => status == 'checked_in';
  bool get isUsable => status == 'issued' || status == 'checked_in';

  @override
  List<Object?> get props => [
    id,
    status,
    checkedInAt,
    createdAt,
    ticketTier,
    seats,
    event,
  ];
}

class TicketQREntity extends Equatable {
  final String ticketId;
  final String token;
  final int expiresAtUnix;

  const TicketQREntity({
    required this.ticketId,
    required this.token,
    required this.expiresAtUnix,
  });

  DateTime get expiresAt =>
      DateTime.fromMillisecondsSinceEpoch(expiresAtUnix * 1000);

  @override
  List<Object?> get props => [ticketId, token, expiresAt];
}

class TicketSeat extends Equatable {
  const TicketSeat({
    required this.id,
    this.section,
    this.rowLabel,
    this.seatLabel,
  });

  final String id;
  final String? section;
  final String? rowLabel;
  final String? seatLabel;

  /// "A12" or "Section B · A12" or null when no human label is set.
  String? get displayLabel {
    final parts = <String>[
      if ((section ?? '').isNotEmpty) section!,
      if ((rowLabel ?? '').isNotEmpty) rowLabel!,
      if ((seatLabel ?? '').isNotEmpty) seatLabel!,
    ];
    return parts.isEmpty ? null : parts.join(' · ');
  }

  @override
  List<Object?> get props => [id, section, rowLabel, seatLabel];
}
