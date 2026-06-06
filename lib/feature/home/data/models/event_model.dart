// ==============================================================================
// lib/feature/home/data/models/event_model.dart
// Wire model for the /events-list response row.
//
// The endpoint returns nested objects via PostgREST embedding:
//
//   {
//     id, title, category, hero_image_url, starts_at, ends_at, is_featured,
//     venue: { name, address, city, country },     // nullable when venue_id is null
//     tiers: [ { price_paisa }, ... ],             // empty when no tiers exist
//     ...
//   }
//
// We flatten the venue fields into top-level properties and reduce the tiers
// array into a min / max / isFree summary so the bloc and UI can stay simple.
// ==============================================================================

import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

class EventModel {
  const EventModel({
    required this.id,
    required this.title,
    required this.category,
    required this.isFeatured,
    required this.startsAt,
    this.heroImageUrl,
    this.venueId,
    this.description,
    this.endsAt,
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

  final String id;
  final String title;
  final String category;
  final bool isFeatured;
  final DateTime startsAt;
  final String? heroImageUrl;
  final String? venueId;
  final String? description;
  final DateTime? endsAt;

  final String? venueName;
  final String? venueAddress;
  final String? venueCity;
  final String? venueCountry;

  final int? minPricePaisa;
  final int? maxPricePaisa;
  final bool isFree;
  final bool isFavorited;

  // Populated only by /events-nearby (the map feed); null elsewhere.
  final double? latitude;
  final double? longitude;
  final double? distanceM;

  factory EventModel.fromJson(final Map<String, dynamic> json) {
    final DateTime? starts = _asDate(json['starts_at']);
    if (starts == null) {
      throw const JsonParsingException(
        message: 'Event row is missing required starts_at',
      );
    }

    final Map<String, dynamic>? venue = _asMap(json['venue']);
    final _PriceSummary price = _summarizeTiers(json['tiers']);

    return EventModel(
      id: (json['id'] as String?)?.trim() ?? '',
      title: (json['title'] as String?)?.trim() ?? '',
      category: (json['category'] as String?)?.trim() ?? '',
      isFeatured: json['is_featured'] == true,
      startsAt: starts,
      heroImageUrl: (json['hero_image_url'] as String?)?.trim(),
      venueId: (json['venue_id'] as String?)?.trim(),
      description: (json['description'] as String?)?.trim(),
      endsAt: _asDate(json['ends_at']),
      venueName: (venue?['name'] as String?)?.trim(),
      venueAddress: (venue?['address'] as String?)?.trim(),
      venueCity: (venue?['city'] as String?)?.trim(),
      venueCountry: (venue?['country'] as String?)?.trim(),
      minPricePaisa: price.min,
      maxPricePaisa: price.max,
      isFree: price.isFree,
      isFavorited: json['is_favorited'] == true,
      latitude: _asDouble(json['latitude']),
      longitude: _asDouble(json['longitude']),
      distanceM: _asDouble(json['distance_m']),
    );
  }

  Event toEntity() => Event(
    id: id,
    title: title,
    category: category,
    isFeatured: isFeatured,
    heroImageUrl: heroImageUrl,
    venueId: venueId,
    description: description,
    startsAt: startsAt,
    endsAt: endsAt,
    venueName: venueName,
    venueAddress: venueAddress,
    venueCity: venueCity,
    venueCountry: venueCountry,
    minPricePaisa: minPricePaisa,
    maxPricePaisa: maxPricePaisa,
    isFree: isFree,
    isFavorited: isFavorited,
    latitude: latitude,
    longitude: longitude,
    distanceM: distanceM,
  );

  // ─── parsing helpers ──────────────────────────────────────────────────────

  static DateTime? _asDate(final Object? value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  static Map<String, dynamic>? _asMap(final Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static int? _asInt(final Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _asDouble(final Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// Collapses the tiers array into a min / max / isFree summary.
  /// Returns all-null + isFree=false when the event has no tiers yet — we
  /// cannot say a price-less event is free.
  static _PriceSummary _summarizeTiers(final Object? raw) {
    if (raw is! List || raw.isEmpty) {
      return const _PriceSummary(min: null, max: null, isFree: false);
    }
    int? min;
    int? max;
    bool allFree = true;
    for (final Object? row in raw) {
      if (row is! Map) continue;
      final int? price = _asInt(row['price_paisa']);
      if (price == null) continue;
      if (price > 0) allFree = false;
      min = (min == null || price < min) ? price : min;
      max = (max == null || price > max) ? price : max;
    }
    if (min == null) {
      // Tiers existed but none had a usable price_paisa.
      return const _PriceSummary(min: null, max: null, isFree: false);
    }
    return _PriceSummary(min: min, max: max, isFree: allFree);
  }
}

class _PriceSummary {
  const _PriceSummary({
    required this.min,
    required this.max,
    required this.isFree,
  });

  final int? min;
  final int? max;
  final bool isFree;
}
