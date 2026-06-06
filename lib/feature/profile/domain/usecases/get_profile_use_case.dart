import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/feature/profile/domain/repositories/profile_repository.dart';

@lazySingleton
class GetProfileUseCase implements UseCase<UserProfile, NoParams> {
  GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  EitherFailure<UserProfile> call(NoParams params) => _repository.getProfile();
}
