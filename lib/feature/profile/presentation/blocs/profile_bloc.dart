import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/auth/domain/usecases/change_password_use_case.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/feature/profile/domain/usecases/get_profile_use_case.dart';
import 'package:tap_app/feature/profile/domain/usecases/update_avatar_use_case.dart';
import 'package:tap_app/feature/profile/domain/usecases/update_profile_use_case.dart';

part 'profile_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class ProfileEvent with _$ProfileEvent implements BaseEvent {
  const factory ProfileEvent.started() = ProfileStarted;
  const factory ProfileEvent.refreshed() = ProfileRefreshed;
  const factory ProfileEvent.saveRequested(UpdateProfileParams params) =
      ProfileSaveRequested;
  const factory ProfileEvent.passwordChangeRequested(String newPassword) =
      ProfilePasswordChangeRequested;
  const factory ProfileEvent.avatarChangeRequested(File file) =
      ProfileAvatarChangeRequested;
}

// ─── Status ──────────────────────────────────────────────────────────────────
enum ProfileStatus { idle, loading, loaded, failure }

enum ProfileSaveStatus { idle, saving, success, failure }

// ─── State ───────────────────────────────────────────────────────────────────
@freezed
abstract class ProfileState with _$ProfileState implements BaseState {
  const factory ProfileState({
    @Default(ProfileStatus.idle) ProfileStatus status,
    UserProfile? profile,
    String? error,
    @Default(ProfileSaveStatus.idle) ProfileSaveStatus saveStatus,
    String? saveError,
    @Default(false) bool isUploadingAvatar,
  }) = _ProfileState;

  const ProfileState._();

  bool get isLoading => status == ProfileStatus.loading;
  bool get hasLoaded => status == ProfileStatus.loaded;
  bool get isSaving => saveStatus == ProfileSaveStatus.saving;
  bool get saveSucceeded => saveStatus == ProfileSaveStatus.success;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getProfile,
    this._updateProfile,
    this._changePassword,
    this._updateAvatar,
  ) : super(const ProfileState()) {
    on<ProfileStarted>(_onLoad);
    on<ProfileRefreshed>(_onLoad);
    on<ProfileSaveRequested>(_onSaveRequested);
    on<ProfilePasswordChangeRequested>(_onPasswordChange);
    on<ProfileAvatarChangeRequested>(_onAvatarChange);
  }

  final GetProfileUseCase _getProfile;
  final UpdateProfileUseCase _updateProfile;
  final ChangePasswordUseCase _changePassword;
  final UpdateAvatarUseCase _updateAvatar;

  // Shared by started + refreshed. Typed on the base event so one handler
  // serves both.
  Future<void> _onLoad(
    final ProfileEvent event,
    final Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, error: null));

    final result = await _getProfile(const NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProfileStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (profile) =>
          emit(state.copyWith(status: ProfileStatus.loaded, profile: profile)),
    );
  }

  Future<void> _onSaveRequested(
    final ProfileSaveRequested event,
    final Emitter<ProfileState> emit,
  ) async {
    if (state.isSaving) return;

    emit(state.copyWith(saveStatus: ProfileSaveStatus.saving, saveError: null));

    final result = await _updateProfile(event.params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveStatus: ProfileSaveStatus.failure,
          saveError: getErrorMessage(failure),
        ),
      ),
      // Update the held profile from the response so the header refreshes
      // without a second load.
      (profile) => emit(
        state.copyWith(saveStatus: ProfileSaveStatus.success, profile: profile),
      ),
    );
  }

  // Password change reuses saveStatus so the edit screen's existing listener
  // (pop on success, snackbar on failure) drives the UI unchanged.
  Future<void> _onPasswordChange(
    final ProfilePasswordChangeRequested event,
    final Emitter<ProfileState> emit,
  ) async {
    if (state.isSaving) return;

    emit(state.copyWith(saveStatus: ProfileSaveStatus.saving, saveError: null));

    final result = await _changePassword(
      ChangePasswordParams(event.newPassword),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveStatus: ProfileSaveStatus.failure,
          saveError: getErrorMessage(failure),
        ),
      ),
      (_) => emit(state.copyWith(saveStatus: ProfileSaveStatus.success)),
    );
  }

  // Avatar upload has its own flag so the header can show a spinner without
  // colliding with the form-save state used by the edit screen.
  Future<void> _onAvatarChange(
    final ProfileAvatarChangeRequested event,
    final Emitter<ProfileState> emit,
  ) async {
    if (state.isUploadingAvatar) return;

    emit(state.copyWith(isUploadingAvatar: true, saveError: null));

    final result = await _updateAvatar(event.file);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isUploadingAvatar: false,
          saveError: getErrorMessage(failure),
        ),
      ),
      // The updated profile carries the new avatar URL, so the held profile
      // refreshes the header without a second load.
      (profile) =>
          emit(state.copyWith(isUploadingAvatar: false, profile: profile)),
    );
  }
}
