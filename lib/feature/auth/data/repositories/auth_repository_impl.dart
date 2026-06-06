// ==============================================================================
// lib/feature/auth/data/repositories/auth_repository_impl.dart
// Calls the remote data source through BaseRepository.execute so any thrown
// exception becomes a typed Failure. On success, persists tokens to storage
// so the AuthInterceptor will attach the bearer to subsequent calls.
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_session_service.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._session);

  final AuthRemoteDataSource _remote;
  final AuthSessionService _session;

  @override
  Future<Either<Failure, AuthSession>> loginWithEmail({
    required final String email,
    required final String password,
  }) {
    return execute<AuthSession>(
      operation: () async {
        final dto = await _remote.loginWithEmail(
          email: email,
          password: password,
        );

        await _session.persistSession(
          accessToken: dto.accessToken,
          refreshToken: dto.refreshToken,
          expiresIn: Duration(seconds: dto.expiresIn),
        );
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, AuthSession>> signupWithEmail({
    required String username,
    required String email,
    required String password,
  }) {
    return execute(
      operation: () async {
        final dto = await _remote.signupWithEmail(
          username: username,
          email: email,
          password: password,
        );
        // Supabase email-signup may return a session immediately (when email
        // confirmation is off) or only a user (when it is on). Persist when
        // we got one so the user lands signed-in.
        if (dto.accessToken.isNotEmpty) {
          await _session.persistSession(
            accessToken: dto.accessToken,
            refreshToken: dto.refreshToken,
            expiresIn: Duration(seconds: dto.expiresIn),
          );
        }
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return executeVoid(
      operation: () async {
        // Best-effort server logout — even if the server returns an error
        // we still want to drop local credentials so the user is signed out
        // on this device.
        try {
          await _remote.logout();
        } on Object {
          // swallowed: the local sign-out below is what matters for UX.
        }
        await _session.signOut();
      },
    );
  }

  @override
  Future<Either<Failure, CurrentUser>> getCurrentUser() {
    return execute<CurrentUser>(
      operation: () async {
        final dto = await _remote.getCurrentUser();
        return dto.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(final String newPassword) {
    return executeVoid(operation: () => _remote.updatePassword(newPassword));
  }
}
