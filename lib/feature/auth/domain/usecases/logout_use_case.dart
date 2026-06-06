// ==============================================================================
// lib/feature/auth/domain/usecases/logout_use_case.dart
// Sign the user out. Calls the server logout (best-effort) and clears local
// credentials. Emits SessionSignedOut via AuthSessionService so the global
// SessionListener routes the user to the auth flow.
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LogoutUseCase implements UseCase<Unit, NoParams> {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(final NoParams params) =>
      _repository.logout();
}
