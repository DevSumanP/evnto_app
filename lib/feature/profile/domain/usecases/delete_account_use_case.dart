import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/profile/domain/repositories/profile_repository.dart';

@lazySingleton
class DeleteAccountUseCase implements UseCase<Unit, NoParams> {
  DeleteAccountUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  EitherFailure<Unit> call(NoParams params) => _repository.deleteAccount();
}
