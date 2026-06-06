import 'package:tap_app/core/errors/exceptions.dart';

import '../../../event-detail/domain/entities/event_detail.dart';
import '../../../home/domain/entities/event_entity.dart';
import '../../domain/entities/ticket_entity.dart';

class TicketModel {
  const TicketModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.tier,
    required this.event,
    this.checkedInAt,
    this.seat,
  });

  final String id;
  final String status;
  final DateTime createdAt;
  final TicketTier tier;
  final Event event;
  final DateTime? checkedInAt;
  final TicketSeat? seat;

  factory TicketModel.fromJson(final Map<String, dynamic> json) {
    final DateTime? created = _asDate(json['created_at']);
    if (created == null) {
      throw const JsonParsingException(
        message: 'ticket row missing created_at',
      );
    }

    final Map<String, dynamic>? tierJson = _asMap(json['ticket_tiers']);
    final Map<String, dynamic>? eventJson = _asMap(json['events']);
    if (tierJson == null || eventJson == null) {
      throw const JsonParsingException(
        message: 'ticket row missing ticket_tiers or events join',
      );
    }

    return TicketModel(
      id: (json['id'] as String?)?.trim() ?? '',
      status: (json['status'] as String?)?.trim() ?? '',
      createdAt: created,
      checkedInAt: _asDate(json['checked_in_at']),
      tier: _tierFromJson(tierJson),
      event: _eventFromJson(eventJson),
      seat: _seatFromJson(_asMap(json['seats'])),
    );
  }

  TicketEntity toEntity() => TicketEntity(
    id: id,
    status: status,
    createdAt: createdAt,
    checkedInAt: checkedInAt,
    ticketTier: tier,
    event: event,
    seats: seat,
  );

  // ─── nested-shape helpers ─────────────────────────────────────────────────

  static TicketTier _tierFromJson(final Map<String, dynamic> j) => TicketTier(
    id: (j['id'] as String?)?.trim() ?? '',
    name: (j['name'] as String?)?.trim() ?? '',
    pricePaisa: _asInt(j['price_paisa']) ?? 0,
    quantityTotal: 0,
    quantitySold: 0,
    isSeated: false,
    sortOrder: 0,
  );

  static Event _eventFromJson(final Map<String, dynamic> j) {
    final Map<String, dynamic>? venueJson = _asMap(j['venues']);
    final DateTime? starts = _asDate(j['starts_at']);
    if (starts == null) {
      throw const JsonParsingException(
        message: 'ticket.events row missing starts_at',
      );
    }
    return Event(
      id: (j['id'] as String?)?.trim() ?? '',
      title: (j['title'] as String?)?.trim() ?? '',
      category: '',
      isFeatured: false,
      heroImageUrl: (j['hero_image_url'] as String?)?.trim(),
      venueId: null,
      description: null,
      startsAt: starts,
      endsAt: _asDate(j['ends_at']),
      venueName: (venueJson?['name'] as String?)?.trim(),
      venueAddress: (venueJson?['address'] as String?)?.trim(),
      venueCity: (venueJson?['city'] as String?)?.trim(),
    );
  }

  static TicketSeat? _seatFromJson(final Map<String, dynamic>? j) {
    if (j == null) return null;
    return TicketSeat(
      id: (j['id'] as String?)?.trim() ?? '',
      section: (j['section'] as String?)?.trim(),
      rowLabel: (j['row_label'] as String?)?.trim(),
      seatLabel: (j['seat_label'] as String?)?.trim(),
    );
  }
}

class TicketQrModel {
  const TicketQrModel({
    required this.ticketId,
    required this.token,
    required this.expiresAt,
  });

  final String ticketId;
  final String token;
  final DateTime expiresAt;

  factory TicketQrModel.fromJson(final Map<String, dynamic> json) {
    final int? unix = _asInt(json['expires_at_unix']);
    if (unix == null) {
      throw const JsonParsingException(
        message: 'ticket-qr response missing expires_at_unix',
      );
    }
    return TicketQrModel(
      ticketId: (json['ticket_id'] as String?)?.trim() ?? '',
      token: (json['token'] as String?)?.trim() ?? '',
      expiresAt: DateTime.fromMillisecondsSinceEpoch(unix * 1000),
    );
  }

  TicketQREntity toEntity() => TicketQREntity(
    ticketId: ticketId,
    token: token,
    expiresAtUnix: expiresAt.microsecondsSinceEpoch,
  );
}

// ─── shared parsing helpers ────────────────────────────────────────────────
DateTime? _asDate(final Object? v) =>
    v is String && v.isNotEmpty ? DateTime.tryParse(v) : null;
Map<String, dynamic>? _asMap(final Object? v) {
  if (v is Map<String, dynamic>) return v;
  if (v is Map) return Map<String, dynamic>.from(v);
  return null;
}

int? _asInt(final Object? v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}
