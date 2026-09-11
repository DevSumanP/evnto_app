// ==============================================================================
// lib/feature/home/presentation/blocs/home_layout_bloc.dart
// Drives the SDUI Home. On open it gathers on-device signals, asks the backend
// (Phase A: a bundled mock) for a layout, and holds it for the page to render.
// On any failure — or a layout newer than this build understands — it lands in
// `failure`, which the page treats as "show the legacy Home as a fallback".
// ==============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/core/services/storage_service.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_cubit.dart';
import 'package:tap_app/feature/home/domain/entities/home_layout.dart';
import 'package:tap_app/feature/home/domain/entities/home_signals.dart';
import 'package:tap_app/feature/home/domain/usecases/get_home_layout_use_case.dart';
import 'package:tap_app/feature/tickets/domain/usecases/get_my_tickets_use_case.dart';

// Reuse the per-section status enum instead of defining a second one.
import 'home_bloc.dart' show SectionStatus;

part 'home_layout_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class HomeLayoutEvent with _$HomeLayoutEvent implements BaseBlocEvent {
  const factory HomeLayoutEvent.started() = HomeLayoutStarted;
  const factory HomeLayoutEvent.refreshed() = HomeLayoutRefreshed;
  const factory HomeLayoutEvent.interestsChanged(List<String> interests) =
      HomeLayoutInterestsChanged;
}

// ─── State ──────────────────────────────────────────────────────────────────
@freezed
abstract class HomeLayoutState with _$HomeLayoutState implements BaseBlocState {
  const factory HomeLayoutState({
    @Default(SectionStatus.idle) SectionStatus status,
    HomeLayout? layout,
    String? error,
  }) = _HomeLayoutState;

  const HomeLayoutState._();

  bool get isLoading =>
      status == SectionStatus.idle || status == SectionStatus.loading;
  bool get hasLayout => status == SectionStatus.loaded && layout != null;
  bool get isFailure => status == SectionStatus.failure;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class HomeLayoutBloc extends BaseBloc<HomeLayoutEvent, HomeLayoutState> {
  HomeLayoutBloc(
    this._getHomeLayout,
    this._getMyTickets,
    this._storage,
    this._favorites,
  ) : super(const HomeLayoutState()) {
    on<HomeLayoutStarted>((event, emit) => _load(emit, recordOpen: true));
    on<HomeLayoutRefreshed>((event, emit) => _load(emit));
    on<HomeLayoutInterestsChanged>(_onInterestsChanged);
  }

  final GetHomeLayoutUseCase _getHomeLayout;
  final GetMyTicketsUseCase _getMyTickets;
  final StorageService _storage;
  final FavoritesCubit _favorites;

  Future<void> _load(
    final Emitter<HomeLayoutState> emit, {
    final bool recordOpen = false,
  }) async {
    emit(state.copyWith(status: SectionStatus.loading, error: null));

    // Count this visit once per open (not on pull-to-refresh).
    if (recordOpen) {
      await _storage.recordHomeOpen();
    }

    final (:int count, :bool hasUpcoming) = await _ticketSignals();

    final HomeSignals signals = HomeSignals(
      ticketsCount: count,
      favoritesCount: _favorites.state.favoritedIds.length,
      activeDays: _storage.homeActiveDays,
      hasUpcomingTicket: hasUpcoming,
      interests: _storage.getHomeInterest(),
      city: _storage.getUserCity(),
    );

    final result = await _getHomeLayout(signals);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SectionStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (layout) {
        if (!layout.isSupported) {
          // Backend sent a newer schema than this build can render → fall back.
          emit(
            state.copyWith(
              status: SectionStatus.failure,
              error:
                  'unsupported home layout version (${layout.schemaVersion}).',
            ),
          );
          return;
        }
        emit(state.copyWith(status: SectionStatus.loaded, layout: layout));
      },
    );
  }

  Future<void> _onInterestsChanged(
    final HomeLayoutInterestsChanged event,
    final Emitter<HomeLayoutState> emit,
  ) async {
    await _storage.setHomeInterests(event.interests);
    await _load(emit); // re-resolve so the layout can reflect the new taste
  }

  /// Ticket-derived signals: total count + whether any usable ticket is still
  /// upcoming. A failed tickets call degrades to zero/false so it never blocks
  /// the layout from loading.
  Future<({int count, bool hasUpcoming})> _ticketSignals() async {
    final result = await _getMyTickets(const NoParams());
    return result.fold((_) => (count: 0, hasUpcoming: false), (tickets) {
      final DateTime now = DateTime.now();
      final bool hasUpcoming = tickets.any(
        (t) => t.isUsable && t.event.startsAt.isAfter(now),
      );
      return (count: tickets.length, hasUpcoming: hasUpcoming);
    });
  }
}
