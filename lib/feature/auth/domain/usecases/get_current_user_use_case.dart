// ==============================================================================
// lib/feature/auth/domain/usecases/get_current_user_use_case.dart
// Fetch the signed-in user. Takes no params; the bearer is attached by the
// auth interceptor.
// ==============================================================================

import 'package:injectable/injectable.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/current_user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetCurrentUserUseCase implements UseCase<CurrentUser, NoParams> {
  const GetCurrentUserUseCase(this._repo);

  final AuthRepository _repo;

  @override
  EitherFailure<CurrentUser> call(final NoParams params) =>
      _repo.getCurrentUser();
}
