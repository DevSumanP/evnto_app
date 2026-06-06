// ==============================================================================
// lib/feature/auth/domain/repositories/auth_repository.dart
// Repository contract. The data layer implements this; the use case depends
// on the abstraction so the auth flow is testable without real HTTP.
// ==============================================================================

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_session.dart';
import '../entities/current_user.dart';

abstract class AuthRepository {
  /// Sign in with email and password. On success the returned session has
  /// been persisted to storage so subsequent calls pick up the bearer token.
  Future<Either<Failure, AuthSession>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthSession>> signupWithEmail({
    required String username,
    required String email,
    required String password,
  });

  /// Sign the user out. Calls the server logout endpoint (best-effort) and
  /// clears local credentials. Always succeeds locally: a failing server
  /// call does not block the user from signing out.
  Future<Either<Failure, Unit>> logout();

  /// Fetch the signed-in user from /auth/v1/user. The auth interceptor
  /// attaches the bearer; a stale one will be refreshed first.
  Future<Either<Failure, CurrentUser>> getCurrentUser();

  /// Set a new password for the signed-in user (PUT /auth/v1/user). The auth
  /// interceptor attaches the bearer so Supabase knows which user to update.
  Future<Either<Failure, Unit>> updatePassword(String newPassword);
}
