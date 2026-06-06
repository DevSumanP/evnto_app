// ==============================================================================
// lib/feature/auth/domain/entities/auth_session.dart
// Domain entity. Carries only what the app needs after a successful sign-in.
// Free of any transport / JSON details — those live in the data layer model.
// ==============================================================================

import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.userId,
    required this.email,
  });

  final String accessToken;
  final String refreshToken;
  final Duration expiresIn;
  final String userId;
  final String email;

  @override
  List<Object?> get props => <Object?>[
        accessToken,
        refreshToken,
        expiresIn,
        userId,
        email,
      ];
}
