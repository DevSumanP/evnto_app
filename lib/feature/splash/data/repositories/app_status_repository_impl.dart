// ==============================================================================
// lib/feature/splash/data/repositories/app_status_repository_impl.dart
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/errors/failures.dart';

import '../../domain/repositories/app_status_repository.dart';
import '../datasources/app_status_remote_data_source.dart';

@LazySingleton(as: AppStatusRepository)
class AppStatusRepositoryImpl extends BaseRepository
    implements AppStatusRepository {
  AppStatusRepositoryImpl(this._remoteDataSource);

  final AppStatusRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, AppHealth>> checkAppStatus() {
    return execute(operation: _remoteDataSource.checkAppStatus);
  }
}
