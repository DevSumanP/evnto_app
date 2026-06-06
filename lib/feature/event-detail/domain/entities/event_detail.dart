// ==============================================================================
// lib/feature/event-detail/domain/entities/event_detail.dart
// Entities returned by GET /events-get.
//
// Five types in one file because they are always used together:
//   - EventDetail     : the event row plus its nested objects
//   - Organizer       : always present (events.organizer_id is NOT NULL)
//   - Venue           : nullable (set when events.venue_id is set)
//   - TicketTier      : zero or more tiers attached to the event
//   - SeatTally       : per-tier seat counts for seated tiers
// ==============================================================================

import 'package:equatable/equatable.dart';

class EventDetail extends Equatable {
  const EventDetail({
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

  /// One of 'draft', 'published', 'cancelled', 'archived'.
  /// In practice the detail endpoint only returns 'published'.
  final String status;

  final bool isFeatured;

  /// The organizer that owns this event. Always present.
  final Organizer organizer;

  /// Ticket tiers for this event. Sorted by sort_order ascending. Can be empty
  /// if the organizer has not added any tiers yet.
  final List<TicketTier> tiers;

  /// Seat counts per tier id. Only filled for tiers where is_seated is true.
  /// Empty map for events with no seated tiers.
  final Map<String, SeatTally> seatTallies;

  final String? venueId;
  final String? description;
  final String? heroImageUrl;

  /// The venue for this event. Null when the event has no venue_id.
  final Venue? venue;

  final bool isFavorited;

  // ─── derived helpers ──────────────────────────────────────────────────────

  bool get hasVenue => venue != null;
  bool get hasDescription => (description ?? '').trim().isNotEmpty;
  bool get hasTiers => tiers.isNotEmpty;

  /// True when every tier on the event costs 0 paisa.
  /// False when no tiers exist (we cannot prove a price-less event is free).
  bool get isFree => tiers.isNotEmpty && tiers.every((t) => t.isFree);

  /// Cheapest tier price across all tiers in paisa, or null if there are
  /// no tiers.
  int? get minPricePaisa => tiers.isEmpty
      ? null
      : tiers.map((t) => t.pricePaisa).reduce((a, b) => a < b ? a : b);

  /// Most expensive tier price across all tiers in paisa, or null if there
  /// are no tiers.
  int? get maxPricePaisa => tiers.isEmpty
      ? null
      : tiers.map((t) => t.pricePaisa).reduce((a, b) => a > b ? a : b);

  @override
  List<Object?> get props => [
    id,
    organizerId,
    title,
    slug,
    category,
    startsAt,
    endsAt,
    status,
    isFeatured,
    organizer,
    tiers,
    seatTallies,
    venueId,
    description,
    heroImageUrl,
    venue,
    isFavorited,
  ];
}

class Organizer extends Equatable {
  const Organizer({
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

  @override
  List<Object?> get props => [id, name, slug, verified, logoUrl];
}

class Venue extends Equatable {
  const Venue({
    required this.id,
    required this.name,
    required this.address,
    this.city,
    this.country,
  });

  final String id;
  final String name;
  final String address;

  /// City is nullable in the venues table.
  final String? city;

  /// Country was backfilled to 'Nepal' for existing rows in migration 0007.
  /// New venues may still arrive with country null.
  final String? country;

  @override
  List<Object?> get props => [id, name, address, city, country];
}

class TicketTier extends Equatable {
  const TicketTier({
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

  bool get isFree => pricePaisa == 0;

  int get quantityRemaining =>
      (quantityTotal - quantitySold).clamp(0, quantityTotal);

  bool get isSoldOut => quantityRemaining == 0 && quantityTotal > 0;

  bool get salesNotStarted =>
      salesStartsAt != null && DateTime.now().isBefore(salesStartsAt!);

  bool get salesEnded =>
      salesEndsAt != null && DateTime.now().isAfter(salesEndsAt!);

  /// True when this tier can be bought right now.
  bool get isOnSale => !isSoldOut && !salesNotStarted && !salesEnded;

  @override
  List<Object?> get props => [
    id,
    name,
    pricePaisa,
    quantityTotal,
    quantitySold,
    isSeated,
    sortOrder,
    description,
    color,
    salesStartsAt,
    salesEndsAt,
  ];
}

class SeatTally extends Equatable {
  const SeatTally({this.available = 0, this.held = 0, this.sold = 0});

  final int available;
  final int held;
  final int sold;

  int get total => available + held + sold;

  @override
  List<Object?> get props => [available, held, sold];
}
