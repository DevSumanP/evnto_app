import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/auth/domain/repositories/auth_repository.dart';

class ChangePasswordParams {
  const ChangePasswordParams(this.newPassword);

  final String newPassword;
}

@lazySingleton
class ChangePasswordUseCase implements UseCase<Unit, ChangePasswordParams> {
  ChangePasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  EitherFailure<Unit> call(ChangePasswordParams params) =>
      _repository.updatePassword(params.newPassword);
}
