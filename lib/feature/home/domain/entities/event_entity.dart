// ==============================================================================
// lib/feature/home/domain/entities/event_entity.dart
// ==============================================================================

import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.id,
    required this.title,
    required this.category,
    required this.isFeatured,
    required this.heroImageUrl,
    required this.venueId,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    this.venueName,
    this.venueAddress,
    this.venueCity,
    this.venueCountry,
    this.minPricePaisa,
    this.maxPricePaisa,
    this.isFree = false,
    this.isFavorited = false,
    this.latitude,
    this.longitude,
    this.distanceM,
  });

  /// Event id
  final String id;

  /// Event title
  final String title;

  /// Event category
  final String category;

  final bool isFeatured;

  final String? heroImageUrl;

  final String? venueId;

  final String? description;

  /// Event start date/time
  final DateTime startsAt;

  /// Event end date/time
  final DateTime? endsAt;

  // ─── Venue (joined from /events-list response.venue) ──────────────────────

  final String? venueName;
  final String? venueAddress;
  final String? venueCity;
  final String? venueCountry;

  // ─── Price summary (computed from /events-list response.tiers) ────────────

  /// Cheapest ticket price across tiers, in paisa. Null when there are no
  /// tiers on the event yet.
  final int? minPricePaisa;

  /// Most expensive ticket price across tiers, in paisa. Null when there
  /// are no tiers on the event yet.
  final int? maxPricePaisa;

  /// True when every tier on the event costs 0 paisa.
  /// False when no tiers exist (we cannot prove it is free).
  final bool isFree;

  /// True when the caller has saved this event. False for anonymous callers
  /// or when the field is missing from the response. Used to hydrate
  /// FavoritesCubit on data load — the cubit is the runtime source of truth.
  final bool isFavorited;

  // ─── Location (only populated by /events-nearby for the map) ──────────────

  /// Venue latitude. Null outside the nearby/map feed.
  final double? latitude;

  /// Venue longitude. Null outside the nearby/map feed.
  final double? longitude;

  /// Straight-line distance from the query point, in metres. Null outside the
  /// nearby/map feed.
  final double? distanceM;

  /// True when both coordinates are known, so the event can be placed on a map.
  bool get hasLocation => latitude != null && longitude != null;

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    category,
    startsAt,
    isFeatured,
    heroImageUrl,
    venueId,
    description,
    endsAt,
    venueName,
    venueAddress,
    venueCity,
    venueCountry,
    minPricePaisa,
    maxPricePaisa,
    isFree,
    isFavorited,
    latitude,
    longitude,
    distanceM,
  ];
}
