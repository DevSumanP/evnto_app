import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/feature/profile/domain/repositories/profile_repository.dart';

class UpdateProfileParams extends Equatable {
  const UpdateProfileParams({
    this.displayName,
    this.avatarUrl,
    this.phone,
    this.city,
    this.country,
  });

  final String? displayName;
  final String? avatarUrl;
  final String? phone;
  final String? city;
  final String? country;

  @override
  List<Object?> get props => <Object?>[
    displayName,
    avatarUrl,
    phone,
    city,
    country,
  ];
}

@lazySingleton
class UpdateProfileUseCase
    implements UseCase<UserProfile, UpdateProfileParams> {
  UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  EitherFailure<UserProfile> call(UpdateProfileParams params) =>
      _repository.updateProfile(
        displayName: params.displayName,
        avatarUrl: params.avatarUrl,
        phone: params.phone,
        city: params.city,
        country: params.country,
      );
}
