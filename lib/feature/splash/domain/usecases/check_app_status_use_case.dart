// ==============================================================================
// lib/feature/splash/domain/usecases/check_app_status_use_case.dart
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../../data/datasources/app_status_remote_data_source.dart';
import '../repositories/app_status_repository.dart';

@lazySingleton
class CheckAppStatusUseCase implements UseCase<AppHealth, NoParams> {
  CheckAppStatusUseCase(this._repository);

  final AppStatusRepository _repository;

  @override
  Future<Either<Failure, AppHealth>> call(final NoParams params) =>
      _repository.checkAppStatus();
}
