// ==============================================================================
// lib/feature/location/domain/entities/user_location.dart
// The location the user has picked. Saved to the profile and to local storage.
// ==============================================================================

import 'package:equatable/equatable.dart';

class UserLocation extends Equatable {
  const UserLocation({required this.city, this.country});

  final String city;
  final String? country;

  @override
  List<Object?> get props => <Object?>[city, country];
}
