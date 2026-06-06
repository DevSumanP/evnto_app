// ==============================================================================
// lib/feature/home/presentation/blocs/home_bloc.dart
// Drives the Home / Discover tab.
//
// Three independent sections (upcoming, popular, suggested). Each has its
// own status so a failure in one section does not blank the others.
//
// Events:
//   - started               : first load. Reads stored city, then triggers
//                             all three section reloads in parallel.
//   - refreshed             : pull-to-refresh. Same flow as started.
//   - queryChanged          : update the client-side search filter.
//   - upcomingRetried       : reload only the Upcoming Events section.
//   - popularRetried        : reload only the Popular Now section.
//   - suggestionsRetried    : reload only the Suggestion-for-you section.
//                             If no city is stored, this emits an empty
//                             loaded state so the UI can hide the section.
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
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/feature/home/domain/usecases/get_popular_event_use_case.dart';
import 'package:tap_app/feature/home/domain/usecases/get_suggested_event_use_case.dart';
import 'package:tap_app/feature/home/domain/usecases/get_upcoming_event_use_case.dart';

part 'home_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────

@freezed
class HomeEvent with _$HomeEvent implements BaseBlocEvent {
  const factory HomeEvent.started() = HomeStarted;
  const factory HomeEvent.refreshed() = HomeRefreshed;
  const factory HomeEvent.queryChanged(String query) = HomeQueryChanged;
  const factory HomeEvent.upcomingRetried() = HomeUpcomingRetried;
  const factory HomeEvent.popularRetried() = HomePopularRetried;
  const factory HomeEvent.suggestionsRetried() = HomeSuggestionsRetried;
}

// ─── Per-section status ──────────────────────────────────────────────────────

enum SectionStatus { idle, loading, loaded, failure }

// ─── State ───────────────────────────────────────────────────────────────────

@freezed
abstract class HomeState with _$HomeState implements BaseBlocState {
  const factory HomeState({
    @Default('') String query,
    @Default(<Event>[]) List<Event> upcoming,
    @Default(<Event>[]) List<Event> popular,
    @Default(<Event>[]) List<Event> suggested,
    @Default(SectionStatus.idle) SectionStatus upcomingStatus,
    @Default(SectionStatus.idle) SectionStatus popularStatus,
    @Default(SectionStatus.idle) SectionStatus suggestedStatus,
    String? upcomingError,
    String? popularError,
    String? suggestedError,
    String? city,
    String? country,
  }) = _HomeState;

  const HomeState._();

  bool get hasCity => (city ?? '').isNotEmpty;

  /// Upcoming events filtered by the current search query.
  List<Event> get filteredUpcoming => _filter(upcoming);

  /// Popular events filtered by the current search query.
  List<Event> get filteredPopular => _filter(popular);

  /// Suggested events filtered by the current search query.
  List<Event> get filteredSuggested => _filter(suggested);

  List<Event> _filter(final List<Event> source) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return source;
    return source
        .where((final Event e) => e.title.toLowerCase().contains(q))
        .toList(growable: false);
  }
}

// ─── Bloc ────────────────────────────────────────────────────────────────────

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(
    this._getUpcoming,
    this._getPopular,
    this._getSuggested,
    this._storage,
    this._favorites,
  ) : super(const HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeRefreshed>(_onRefreshed);
    on<HomeQueryChanged>(_onQueryChanged);
    on<HomeUpcomingRetried>(_onUpcomingRetried);
    on<HomePopularRetried>(_onPopularRetried);
    on<HomeSuggestionsRetried>(_onSuggestionsRetried);
  }

  final GetUpcomingEventUseCase _getUpcoming;
  final GetPopularEventsUseCase _getPopular;
  final GetSuggestedEventUseCase _getSuggested;
  final StorageService _storage;
  final FavoritesCubit _favorites;

  Future<void> _onStarted(
    final HomeStarted event,
    final Emitter<HomeState> emit,
  ) async {
    _emitCitySnapshot(emit);
    _dispatchAllSections();
  }

  Future<void> _onRefreshed(
    final HomeRefreshed event,
    final Emitter<HomeState> emit,
  ) async {
    _emitCitySnapshot(emit);
    _dispatchAllSections();
  }

  void _onQueryChanged(
    final HomeQueryChanged event,
    final Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(query: event.query));
  }

  Future<void> _onUpcomingRetried(
    final HomeUpcomingRetried event,
    final Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        upcomingStatus: SectionStatus.loading,
        upcomingError: null,
      ),
    );
    final result = await _getUpcoming(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          upcomingStatus: SectionStatus.failure,
          upcomingError: getErrorMessage(failure),
        ),
      ),
      (events) {
        _favorites.hydrateFromEvents(events);
        emit(
          state.copyWith(
            upcomingStatus: SectionStatus.loaded,
            upcoming: events,
          ),
        );
      },
    );
  }

  Future<void> _onPopularRetried(
    final HomePopularRetried event,
    final Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(popularStatus: SectionStatus.loading, popularError: null),
    );
    final result = await _getPopular(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          popularStatus: SectionStatus.failure,
          popularError: getErrorMessage(failure),
        ),
      ),
      (events) {
        _favorites.hydrateFromEvents(events);
        emit(
          state.copyWith(popularStatus: SectionStatus.loaded, popular: events),
        );
      },
    );
  }

  Future<void> _onSuggestionsRetried(
    final HomeSuggestionsRetried event,
    final Emitter<HomeState> emit,
  ) async {
    final String? city = state.city;
    if (city == null || city.isEmpty) {
      // No city stored. Emit loaded + empty so the UI can hide the
      // section instead of spinning forever.
      emit(
        state.copyWith(
          suggestedStatus: SectionStatus.loaded,
          suggested: const <Event>[],
          suggestedError: null,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        suggestedStatus: SectionStatus.loading,
        suggestedError: null,
      ),
    );
    final result = await _getSuggested(GetSuggestedEventParams(city: city));
    result.fold(
      (failure) => emit(
        state.copyWith(
          suggestedStatus: SectionStatus.failure,
          suggestedError: getErrorMessage(failure),
        ),
      ),
      (events) {
        _favorites.hydrateFromEvents(events);
        emit(
          state.copyWith(
            suggestedStatus: SectionStatus.loaded,
            suggested: events,
          ),
        );
      },
    );
  }

  void _emitCitySnapshot(final Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        city: _storage.getUserCity(),
        country: _storage.getUserCountry(),
      ),
    );
  }

  void _dispatchAllSections() {
    // Fire the three section reloads as separate events. Each handler owns
    // its own emit, so the three reloads run in parallel without stepping
    // on each other.
    add(const HomeEvent.upcomingRetried());
    add(const HomeEvent.popularRetried());
    add(const HomeEvent.suggestionsRetried());
  }
}
