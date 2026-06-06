import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/feature/profile/domain/repositories/profile_repository.dart';

@lazySingleton
class UpdateAvatarUseCase implements UseCase<UserProfile, File> {
  UpdateAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  EitherFailure<UserProfile> call(File file) =>
      _repository.updateAvatar(file: file);
}
