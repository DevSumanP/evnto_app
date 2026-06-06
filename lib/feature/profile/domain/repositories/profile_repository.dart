import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  EitherFailure<UserProfile> getProfile();

  EitherFailure<UserProfile> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? phone,
    String? city,
    String? country,
  });

  /// Upload [file] as the caller's new avatar, then save the resulting URL on
  /// the profile row. Returns the updated profile.
  EitherFailure<UserProfile> updateAvatar({required File file});

  // EitherFailure<List<OrderSummary>> getMyOrders();

  EitherFailure<Unit> setNotifications({required bool enabled});

  EitherFailure<Unit> deleteAccount();
}
