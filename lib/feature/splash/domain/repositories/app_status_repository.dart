// ==============================================================================
// lib/feature/splash/domain/repositories/app_status_repository.dart
// ==============================================================================

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/datasources/app_status_remote_data_source.dart';

abstract class AppStatusRepository {
  /// Returns Right(AppHealth) on success, Left(Failure) on network or
  /// server error. The use case decides what to do with each.
  Future<Either<Failure, AppHealth>> checkAppStatus();
}
