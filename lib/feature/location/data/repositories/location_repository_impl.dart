// ==============================================================================
// lib/feature/location/data/repositories/location_repository_impl.dart
// Composes the remote and device data sources behind the LocationRepository
// contract. Persists the chosen city to local storage on save so the splash
// can skip the Choose Location screen on subsequent launches.
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/popular_location.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_device_data_source.dart';
import '../datasources/location_remote_data_source.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends BaseRepository
    implements LocationRepository {
  LocationRepositoryImpl(this._remote, this._device, this._storage);

  final LocationRemoteDataSource _remote;
  final LocationDeviceDataSource _device;
  final StorageService _storage;

  @override
  EitherFailure<List<PopularLocation>> getPopularLocations({
    final int limit = 10,
  }) {
    return execute<List<PopularLocation>>(
      operation: () async {
        final models = await _remote.getPopularLocations(limit: limit);
        return models.map((m) => m.toEntity()).toList(growable: false);
      },
    );
  }

  @override
  EitherFailure<UserLocation> resolveCurrentLocation() {
    return execute<UserLocation>(
      operation: () => _device.readCurrentLocation(),
    );
  }

  @override
  Future<Either<Failure, Unit>> saveUserLocation(final UserLocation location) {
    return executeVoid(
      operation: () async {
        await _remote.updateProfileLocation(
          city: location.city,
          country: location.country,
        );
        await _storage.setUserLocation(
          city: location.city,
          country: location.country,
        );
      },
    );
  }
}
