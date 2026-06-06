// ==============================================================================
// lib/feature/location/domain/entities/popular_location.dart
// One row in the "Popular location" list on the Choose Location screen.
// ==============================================================================

import 'package:equatable/equatable.dart';

class PopularLocation extends Equatable {
  const PopularLocation({
    required this.city,
    this.country,
    this.venueCount = 0,
  });

  /// City name as shown in the list (for example "Los Angeles").
  final String city;

  /// Optional country/region label. Not always known.
  final String? country;

  /// Number of venues in this city. Used to rank the list.
  final int venueCount;

  @override
  List<Object?> get props => <Object?>[city, country, venueCount];
}
