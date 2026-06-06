// ==============================================================================
// lib/feature/location/domain/repositories/location_repository.dart
// Domain contract for the Choose Location feature.
// ==============================================================================

import 'package:dartz/dartz.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/errors/failures.dart';
import '../entities/popular_location.dart';
import '../entities/user_location.dart';

abstract class LocationRepository {
  /// Fetch the most common cities to show in the "Popular location" list.
  EitherFailure<List<PopularLocation>> getPopularLocations({final int limit});

  /// Read the user's current GPS position and reverse-geocode it to a city.
  /// Throws via Left() if location services are off or permission is denied.
  EitherFailure<UserLocation> resolveCurrentLocation();

  /// Persist the user's chosen city: write to the profile and local storage.
  Future<Either<Failure, Unit>> saveUserLocation(final UserLocation location);
}
