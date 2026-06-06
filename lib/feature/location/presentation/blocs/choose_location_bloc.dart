// ==============================================================================
// lib/feature/location/presentation/blocs/choose_location_bloc.dart
// Drives the "Choose your location" screen.
//
// Events:
//   - started         : load the popular cities
//   - queryChanged    : update the search filter (popular list is filtered
//                       client-side; backend has no fuzzy search yet)
//   - useCurrentRequested : resolve via GPS, then save
//   - locationSelected    : save the chosen city
//   - errorDismissed
// ==============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/location/domain/entities/popular_location.dart';
import 'package:tap_app/feature/location/domain/entities/user_location.dart';
import 'package:tap_app/feature/location/domain/usecases/get_popular_locations_use_case.dart';
import 'package:tap_app/feature/location/domain/usecases/resolve_current_location_use_case.dart';
import 'package:tap_app/feature/location/domain/usecases/save_user_location_use_case.dart';

part 'choose_location_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────

@freezed
class ChooseLocationEvent with _$ChooseLocationEvent implements BaseBlocEvent {
  const factory ChooseLocationEvent.started() = ChooseLocationStarted;
  const factory ChooseLocationEvent.queryChanged(String query) =
      ChooseLocationQueryChanged;
  const factory ChooseLocationEvent.useCurrentRequested() =
      ChooseLocationUseCurrentRequested;
  const factory ChooseLocationEvent.locationSelected({
    required String city,
    String? country,
  }) = ChooseLocationSelected;
  const factory ChooseLocationEvent.errorDismissed() =
      ChooseLocationErrorDismissed;
}

// ─── Status ──────────────────────────────────────────────────────────────────

enum ChooseLocationStatus {
  idle,
  loadingPopular,
  resolvingCurrent,
  saving,
  saved,
  failure,
}

// ─── State ───────────────────────────────────────────────────────────────────

@freezed
abstract class ChooseLocationState
    with _$ChooseLocationState
    implements BaseBlocState {
  const factory ChooseLocationState({
    @Default(<PopularLocation>[]) List<PopularLocation> popular,
    @Default('') String query,
    @Default(ChooseLocationStatus.idle) ChooseLocationStatus status,
    String? failureMessage,
  }) = _ChooseLocationState;

  const ChooseLocationState._();

  bool get isLoadingPopular => status == ChooseLocationStatus.loadingPopular;
  bool get isResolvingCurrent =>
      status == ChooseLocationStatus.resolvingCurrent;
  bool get isSaving => status == ChooseLocationStatus.saving;
  bool get isSaved => status == ChooseLocationStatus.saved;
  bool get isBusy => isResolvingCurrent || isSaving;

  /// Popular list filtered by the current query.
  List<PopularLocation> get filteredPopular {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return popular;
    return popular
        .where((final PopularLocation p) => p.city.toLowerCase().contains(q))
        .toList(growable: false);
  }
}

// ─── Bloc ────────────────────────────────────────────────────────────────────

@injectable
class ChooseLocationBloc
    extends BaseBloc<ChooseLocationEvent, ChooseLocationState> {
  ChooseLocationBloc(this._getPopular, this._resolveCurrent, this._saveLocation)
    : super(const ChooseLocationState()) {
    on<ChooseLocationStarted>(_onStarted);
    on<ChooseLocationQueryChanged>(_onQueryChanged);
    on<ChooseLocationUseCurrentRequested>(_onUseCurrent);
    on<ChooseLocationSelected>(_onLocationSelected);
    on<ChooseLocationErrorDismissed>(_onErrorDismissed);
  }

  final GetPopularLocationsUseCase _getPopular;
  final ResolveCurrentLocationUseCase _resolveCurrent;
  final SaveUserLocationUseCase _saveLocation;

  Future<void> _onStarted(
    final ChooseLocationStarted event,
    final Emitter<ChooseLocationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ChooseLocationStatus.loadingPopular,
        failureMessage: null,
      ),
    );

    final result = await _getPopular(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChooseLocationStatus.failure,
          failureMessage: getErrorMessage(failure),
        ),
      ),
      (cities) => emit(
        state.copyWith(
          status: ChooseLocationStatus.idle,
          popular: cities,
          failureMessage: null,
        ),
      ),
    );
  }

  void _onQueryChanged(
    final ChooseLocationQueryChanged event,
    final Emitter<ChooseLocationState> emit,
  ) {
    emit(state.copyWith(query: event.query));
  }

  Future<void> _onUseCurrent(
    final ChooseLocationUseCurrentRequested event,
    final Emitter<ChooseLocationState> emit,
  ) async {
    if (state.isBusy) return;
    emit(
      state.copyWith(
        status: ChooseLocationStatus.resolvingCurrent,
        failureMessage: null,
      ),
    );

    final result = await _resolveCurrent(const NoParams());
    final UserLocation? resolved = result.fold((failure) {
      emit(
        state.copyWith(
          status: ChooseLocationStatus.failure,
          failureMessage: getErrorMessage(failure),
        ),
      );
      return null;
    }, (loc) => loc);
    if (resolved == null) return;

    await _saveAndEmit(
      city: resolved.city,
      country: resolved.country,
      emit: emit,
    );
  }

  Future<void> _onLocationSelected(
    final ChooseLocationSelected event,
    final Emitter<ChooseLocationState> emit,
  ) async {
    if (state.isBusy) return;
    await _saveAndEmit(city: event.city, country: event.country, emit: emit);
  }

  Future<void> _saveAndEmit({
    required final String city,
    required final String? country,
    required final Emitter<ChooseLocationState> emit,
  }) async {
    emit(
      state.copyWith(status: ChooseLocationStatus.saving, failureMessage: null),
    );

    final result = await _saveLocation(
      SaveUserLocationParams(city: city, country: country),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChooseLocationStatus.failure,
          failureMessage: getErrorMessage(failure),
        ),
      ),
      (_) => emit(state.copyWith(status: ChooseLocationStatus.saved)),
    );
  }

  void _onErrorDismissed(
    final ChooseLocationErrorDismissed event,
    final Emitter<ChooseLocationState> emit,
  ) {
    emit(
      state.copyWith(
        failureMessage: null,
        status: state.status == ChooseLocationStatus.failure
            ? ChooseLocationStatus.idle
            : state.status,
      ),
    );
  }
}
