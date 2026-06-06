import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:tap_app/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/feature/profile/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends BaseRepository
    implements ProfileRepository {
  ProfileRepositoryImpl(this._remote, this._getCurrentUser);

  final ProfileRemoteDataSource _remote;
  final GetCurrentUserUseCase _getCurrentUser;

  @override
  EitherFailure<Unit> deleteAccount() =>
      executeVoid(operation: () => _remote.deleteAccount());

  @override
  EitherFailure<UserProfile> getProfile() => execute(
    operation: () async {
      final model = await _remote.getProfile();
      return model.toEntity(email: await _getEmail());
    },
  );

  @override
  EitherFailure<Unit> setNotifications({required bool enabled}) =>
      executeVoid(operation: () => _remote.setNotifications(enabled: enabled));

  @override
  EitherFailure<UserProfile> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? phone,
    String? city,
    String? country,
  }) => execute(
    operation: () async {
      final model = await _remote.updateProfile(
        displayName: displayName,
        avatarUrl: avatarUrl,
        phone: phone,
        city: city,
        country: country,
      );

      return model.toEntity(email: await _getEmail());
    },
  );

  @override
  EitherFailure<UserProfile> updateAvatar({required File file}) => execute(
    operation: () async {
      final userResult = await _getCurrentUser(const NoParams());
      final userId = userResult.fold((_) => '', (user) => user.id);
      final ext = file.path.split('.').last.toLowerCase();

      final url = await _remote.uploadAvatar(
        userId: userId,
        bytes: await file.readAsBytes(),
        // Supabase serves jpg as image/jpeg; normalise so the content type and
        // the file extension agree.
        fileExt: ext == 'jpg' ? 'jpeg' : ext,
      );

      final model = await _remote.updateProfile(avatarUrl: url);
      return model.toEntity(email: await _getEmail());
    },
  );

  Future<String> _getEmail() async {
    final result = await _getCurrentUser(const NoParams());
    return result.fold((_) => '', (user) => user.email);
  }
}
