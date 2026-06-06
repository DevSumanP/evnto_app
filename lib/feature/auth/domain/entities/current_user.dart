// ==============================================================================
// lib/feature/auth/domain/entities/current_user.dart
// Domain entity for the signed-in user. Holds the few fields the app reads
// outside of the auth flow itself (display name, email, phone).
// ==============================================================================

import 'package:equatable/equatable.dart';

class CurrentUser extends Equatable {
  const CurrentUser({
    required this.id,
    required this.email,
    this.displayName,
    this.phone,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? phone;

  @override
  List<Object?> get props => <Object?>[id, email, displayName, phone];
}
