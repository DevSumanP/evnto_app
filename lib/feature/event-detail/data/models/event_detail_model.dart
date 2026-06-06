// ==============================================================================
// lib/feature/event-detail/data/models/event_detail_model.dart
// Wire models for the /events-get response. Owns JSON parsing.
//
// Response shape (relevant fields, from backend/supabase/functions/events-get):
//
//   {
//     id, organizer_id, venue_id, title, slug, description, category,
//     hero_image_url, starts_at, ends_at, status, is_featured,
//     organizers ( id, name, slug, logo_url, verified ),
//     venues    ( id, name, address, city, seating_map ),       // nullable
//     ticket_tiers [ { id, name, description, price_paisa, quantity_total,
//                      quantity_sold, sales_starts_at, sales_ends_at,
//                      is_seated, color, sort_order }, ... ],
//     seat_summary: { <tier_id>: { available, held, sold } }    // only seated tiers
//   }
//
// Notes:
//   - seating_map is ignored for now; surface it when seated UI is built.
// ==============================================================================

import 'package:tap_app/core/errors/exceptions.dart';

import '../../domain/entities/event_detail.dart';

class EventDetailModel {
  const EventDetailModel({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.slug,
    required this.category,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    required this.isFeatured,
    required this.organizer,
    required this.tiers,
    required this.seatTallies,
    this.venueId,
    this.description,
    this.heroImageUrl,
    this.venue,
    this.isFavorited = false,
  });

  final String id;
  final String organizerId;
  final String title;
  final String slug;
  final String category;
  final DateTime startsAt;
  final DateTime endsAt;
  final String status;
  final bool isFeatured;
  final OrganizerModel organizer;
  final List<TicketTierModel> tiers;
  final Map<String, SeatTallyModel> seatTallies;
  final String? venueId;
  final String? description;
  final String? heroImageUrl;
  final VenueModel? venue;
  final bool isFavorited;

  factory EventDetailModel.fromJson(final Map<String, dynamic> json) {
    final DateTime? starts = _asDate(json['starts_at']);
    final DateTime? ends = _asDate(json['ends_at']);
    if (starts == null || ends == null) {
      throw const JsonParsingException(
        message: 'Event detail row is missing starts_at or ends_at',
      );
    }

    final Map<String, dynamic>? orgJson = _asMap(json['organizers']);
    if (orgJson == null) {
      throw const JsonParsingException(
        message: 'Event detail row is missing required organizer',
      );
    }

    final Map<String, dynamic>? venueJson = _asMap(json['venues']);

    return EventDetailModel(
      id: (json['id'] as String?)?.trim() ?? '',
      organizerId: (json['organizer_id'] as String?)?.trim() ?? '',
      title: (json['title'] as String?)?.trim() ?? '',
      slug: (json['slug'] as String?)?.trim() ?? '',
      category: (json['category'] as String?)?.trim() ?? '',
      startsAt: starts,
      endsAt: ends,
      status: (json['status'] as String?)?.trim() ?? 'published',
      isFeatured: json['is_featured'] == true,
      organizer: OrganizerModel.fromJson(orgJson),
      tiers: _parseTiers(json['ticket_tiers']),
      seatTallies: _parseSeatSummary(json['seat_summary']),
      venueId: (json['venue_id'] as String?)?.trim(),
      description: (json['description'] as String?)?.trim(),
      heroImageUrl: (json['hero_image_url'] as String?)?.trim(),
      venue: venueJson == null ? null : VenueModel.fromJson(venueJson),
      isFavorited: json['is_favorited'] == true,
    );
  }

  EventDetail toEntity() => EventDetail(
    id: id,
    organizerId: organizerId,
    title: title,
    slug: slug,
    category: category,
    startsAt: startsAt,
    endsAt: endsAt,
    status: status,
    isFeatured: isFeatured,
    organizer: organizer.toEntity(),
    tiers: tiers.map((t) => t.toEntity()).toList(growable: false),
    seatTallies: seatTallies.map((k, v) => MapEntry(k, v.toEntity())),
    venueId: venueId,
    description: description,
    heroImageUrl: heroImageUrl,
    venue: venue?.toEntity(),
    isFavorited: isFavorited,
  );

  // ─── parsing helpers ────────────────────────────────────────────────────────

  static List<TicketTierModel> _parseTiers(final Object? raw) {
    if (raw is! List) return const <TicketTierModel>[];
    final List<TicketTierModel> list = raw
        .whereType<Map<String, dynamic>>()
        .map(TicketTierModel.fromJson)
        .toList(growable: false);
    // The /events-get function orders ticket_tiers by sort_order ascending,
    // but resort defensively so the UI never has to.
    list.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return list;
  }

  static Map<String, SeatTallyModel> _parseSeatSummary(final Object? raw) {
    if (raw is! Map) return const <String, SeatTallyModel>{};
    final Map<String, SeatTallyModel> out = <String, SeatTallyModel>{};
    raw.forEach((final Object? k, final Object? v) {
      if (k is String && v is Map) {
        out[k] = SeatTallyModel.fromJson(Map<String, dynamic>.from(v));
      }
    });
    return out;
  }
}

class OrganizerModel {
  const OrganizerModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.verified,
    this.logoUrl,
  });

  final String id;
  final String name;
  final String slug;
  final bool verified;
  final String? logoUrl;

  factory OrganizerModel.fromJson(final Map<String, dynamic> json) {
    return OrganizerModel(
      id: (json['id'] as String?)?.trim() ?? '',
      name: (json['name'] as String?)?.trim() ?? '',
      slug: (json['slug'] as String?)?.trim() ?? '',
      verified: json['verified'] == true,
      logoUrl: (json['logo_url'] as String?)?.trim(),
    );
  }

  Organizer toEntity() => Organizer(
    id: id,
    name: name,
    slug: slug,
    verified: verified,
    logoUrl: logoUrl,
  );
}

class VenueModel {
  const VenueModel({
    required this.id,
    required this.name,
    required this.address,
    this.city,
    this.country,
  });

  final String id;
  final String name;
  final String address;
  final String? city;
  final String? country;

  factory VenueModel.fromJson(final Map<String, dynamic> json) {
    return VenueModel(
      id: (json['id'] as String?)?.trim() ?? '',
      name: (json['name'] as String?)?.trim() ?? '',
      address: (json['address'] as String?)?.trim() ?? '',
      city: (json['city'] as String?)?.trim(),
      country: (json['country'] as String?)?.trim(),
    );
  }

  Venue toEntity() =>
      Venue(id: id, name: name, address: address, city: city, country: country);
}

class TicketTierModel {
  const TicketTierModel({
    required this.id,
    required this.name,
    required this.pricePaisa,
    required this.quantityTotal,
    required this.quantitySold,
    required this.isSeated,
    required this.sortOrder,
    this.description,
    this.color,
    this.salesStartsAt,
    this.salesEndsAt,
  });

  final String id;
  final String name;
  final int pricePaisa;
  final int quantityTotal;
  final int quantitySold;
  final bool isSeated;
  final int sortOrder;
  final String? description;
  final String? color;
  final DateTime? salesStartsAt;
  final DateTime? salesEndsAt;

  factory TicketTierModel.fromJson(final Map<String, dynamic> json) {
    return TicketTierModel(
      id: (json['id'] as String?)?.trim() ?? '',
      name: (json['name'] as String?)?.trim() ?? '',
      pricePaisa: _asInt(json['price_paisa']) ?? 0,
      quantityTotal: _asInt(json['quantity_total']) ?? 0,
      quantitySold: _asInt(json['quantity_sold']) ?? 0,
      isSeated: json['is_seated'] == true,
      sortOrder: _asInt(json['sort_order']) ?? 0,
      description: (json['description'] as String?)?.trim(),
      color: (json['color'] as String?)?.trim(),
      salesStartsAt: _asDate(json['sales_starts_at']),
      salesEndsAt: _asDate(json['sales_ends_at']),
    );
  }

  TicketTier toEntity() => TicketTier(
    id: id,
    name: name,
    pricePaisa: pricePaisa,
    quantityTotal: quantityTotal,
    quantitySold: quantitySold,
    isSeated: isSeated,
    sortOrder: sortOrder,
    description: description,
    color: color,
    salesStartsAt: salesStartsAt,
    salesEndsAt: salesEndsAt,
  );
}

class SeatTallyModel {
  const SeatTallyModel({this.available = 0, this.held = 0, this.sold = 0});

  final int available;
  final int held;
  final int sold;

  factory SeatTallyModel.fromJson(final Map<String, dynamic> json) {
    return SeatTallyModel(
      available: _asInt(json['available']) ?? 0,
      held: _asInt(json['held']) ?? 0,
      sold: _asInt(json['sold']) ?? 0,
    );
  }

  SeatTally toEntity() =>
      SeatTally(available: available, held: held, sold: sold);
}

// ─── shared parsing helpers (file-private) ───────────────────────────────────

DateTime? _asDate(final Object? value) {
  if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
  return null;
}

Map<String, dynamic>? _asMap(final Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

int? _asInt(final Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}
