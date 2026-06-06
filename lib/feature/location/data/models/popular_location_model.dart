// ==============================================================================
// lib/feature/location/data/models/popular_location_model.dart
// Wire model for the /locations-popular response row.
// ==============================================================================

import '../../domain/entities/popular_location.dart';

class PopularLocationModel {
  const PopularLocationModel({
    required this.city,
    this.country,
    this.venueCount = 0,
  });

  final String city;
  final String? country;
  final int venueCount;

  factory PopularLocationModel.fromJson(final Map<String, dynamic> json) {
    return PopularLocationModel(
      city: (json['city'] as String?)?.trim() ?? '',
      country: (json['country'] as String?)?.trim(),
      venueCount: _asInt(json['venue_count']) ?? 0,
    );
  }

  PopularLocation toEntity() =>
      PopularLocation(city: city, country: country, venueCount: venueCount);

  static int? _asInt(final Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
