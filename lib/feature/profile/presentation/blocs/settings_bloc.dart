import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/core/services/storage_service.dart';
import 'package:tap_app/feature/profile/domain/usecases/set_notifications_use_case.dart';

part 'settings_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────

@freezed
class SettingsEvent with _$SettingsEvent implements BaseBlocEvent {
  const factory SettingsEvent.started() = SettingsStarted;
  const factory SettingsEvent.notificationsToggled(bool enabled) =
      SettingsNotificationsToggled;
}

// ─── Status (for the async notifications toggle) ───────────────────────────────

enum NotifToggleStatus { idle, updating, failure }

// ─── State ───────────────────────────────────────────────────────────────────

@freezed
abstract class SettingsState with _$SettingsState implements BaseBlocState {
  const factory SettingsState({
    @Default(true) bool notificationEnabled,
    @Default(NotifToggleStatus.idle) NotifToggleStatus notifStatus,
    String? notifError,
  }) = _SettingsState;

  const SettingsState._();

  bool get isUpdatingNotifications => notifStatus == NotifToggleStatus.updating;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._setNotifications, this._storage)
    : super(const SettingsState()) {
    on<SettingsStarted>(_onStarted);
    on<SettingsNotificationsToggled>(_onNotificationsToggled);
  }

  final SetNotificationsUseCase _setNotifications;
  final StorageService _storage;

  static const String _keyNotifications = 'notifications_enabled';

  // Load persisted prefs into state.
  void _onStarted(
    final SettingsStarted event,
    final Emitter<SettingsState> emit,
  ) {
    emit(
      state.copyWith(
        notificationEnabled: _storage.getBool(_keyNotifications) ?? true,
      ),
    );
  }

  // Async: register/unregister the FCM token. Optimisitc with rever on failure.
  Future<void> _onNotificationsToggled(
    final SettingsNotificationsToggled event,
    final Emitter<SettingsState> emit,
  ) async {
    emit(
      state.copyWith(
        notificationEnabled: event.enabled,
        notifStatus: NotifToggleStatus.updating,
        notifError: null,
      ),
    );

    final result = await _setNotifications(
      SetNotificationParams(enabled: event.enabled),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          notificationEnabled: !event.enabled, // revert
          notifStatus: NotifToggleStatus.failure,
          notifError: getErrorMessage(failure),
        ),
      ),
      (_) {
        _storage.setBool(_keyNotifications, event.enabled);
        emit(state.copyWith(notifStatus: NotifToggleStatus.idle));
      },
    );
  }
}
