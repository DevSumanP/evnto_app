// ==============================================================================
// lib/feature/location/data/datasources/location_device_data_source.dart
// Reads the device's GPS position and turns it into a city/country using
// reverse-geocoding. Used by the "Use my current location" button.
// ==============================================================================

import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user_location.dart';

abstract class LocationDeviceDataSource {
  /// Ask the OS for the current position, reverse-geocode it, and return the
  /// city/country. Throws an [AppException] when the OS denies permission or
  /// location services are off.
  Future<UserLocation> readCurrentLocation();
}

@LazySingleton(as: LocationDeviceDataSource)
class LocationDeviceDataSourceImpl implements LocationDeviceDataSource {
  const LocationDeviceDataSourceImpl();

  @override
  Future<UserLocation> readCurrentLocation() async {
    final bool servicesOn = await Geolocator.isLocationServiceEnabled();
    if (!servicesOn) {
      throw const BusinessRuleException(
        message: 'Turn on location services and try again.',
        code: 'LOCATION_SERVICES_OFF',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw const BusinessRuleException(
        message: 'Location permission is needed to use your current location.',
        code: 'LOCATION_PERMISSION_DENIED',
      );
    }
    if (permission == LocationPermission.deniedForever) {
      throw const BusinessRuleException(
        message: 'Location is blocked. Enable it in Settings and try again.',
        code: 'LOCATION_PERMISSION_BLOCKED',
      );
    }

    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 15),
      ),
    );

    final List<gc.Placemark> placemarks = await gc.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isEmpty) {
      throw const BusinessRuleException(
        message:
            "Could not determine your city. Please pick one from the list.",
        code: 'LOCATION_LOOKUP_FAILED',
      );
    }

    final gc.Placemark p = placemarks.first;
    final String city = _firstNonEmpty(<String?>[
      p.locality,
      p.subAdministrativeArea,
      p.administrativeArea,
    ]);
    if (city.isEmpty) {
      throw const BusinessRuleException(
        message:
            "Could not determine your city. Please pick one from the list.",
        code: 'LOCATION_LOOKUP_FAILED',
      );
    }

    final String? country = (p.country != null && p.country!.isNotEmpty)
        ? p.country
        : null;
    return UserLocation(city: city, country: country);
  }

  String _firstNonEmpty(final List<String?> values) {
    for (final String? v in values) {
      if (v != null && v.trim().isNotEmpty) return v.trim();
    }
    return '';
  }
}
