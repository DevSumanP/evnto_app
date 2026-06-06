// ==============================================================================

// Drives the Explore tab: server-side search with debounce, infinite-scroll
// pagination, category/sort/filter refinement, and a separate map ("near me")
// mode backed by /events-nearby.
//
// Notes:
//   - queryChanged is debounced + restartable (switchMap), so only the last
//     keystroke runs and in-flight searches are dropped.
//   - Any refinement (query, category, sort, filters, clear, refresh) runs a
//     fresh page-1 search via _runSearch and replaces the list.
//   - loadMore appends the next page; guarded so overlapping scroll triggers
//     can't double-fetch.
//   - The card heart reads from FavoritesCubit, so we hydrate it after every
//     load rather than tracking favorited state here.
// ==============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_cubit.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

import '../../data/datasources/recent_searches_store.dart';
import '../../domain/entities/explore_filters.dart';
import '../../domain/usecases/get_nearby_events_use_case.dart';
import '../../domain/usecases/search_events_use_case.dart';

part 'explore_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class ExploreEvent with _$ExploreEvent implements BaseBlocEvent {
  const factory ExploreEvent.started() = ExploreStarted;
  const factory ExploreEvent.queryChanged(String query) = ExploreQueryChanged;
  const factory ExploreEvent.searchSubmitted(String query) =
      ExploreSearchSubmitted;
  const factory ExploreEvent.categorySelected(String? category) =
      ExploreCategorySelected;
  const factory ExploreEvent.sortChanged(ExploreSort sort) = ExploreSortChanged;
  const factory ExploreEvent.filtersApplied(ExploreFilters filters) =
      ExploreFiltersApplied;
  const factory ExploreEvent.loadMore() = ExploreLoadMore;
  const factory ExploreEvent.refreshed() = ExploreRefreshed;
  const factory ExploreEvent.cleared() = ExploreCleared;
  const factory ExploreEvent.recentCleared() = ExploreRecentCleared;
  const factory ExploreEvent.modeToggled() = ExploreModeToggled;
  const factory ExploreEvent.nearbyRequested({
    required double lat,
    required double lng,
    @Default(20000) int radiusM,
  }) = ExploreNearbyRequested;

  /// The map centre was resolved (from GPS or a chosen city). Re-centres and
  /// reloads the nearby feed, and updates the location-pill label.
  const factory ExploreEvent.locationResolved({
    required double lat,
    required double lng,
    String? city,
  }) = ExploreLocationResolved;
}

// ─── Status / mode ─────────────────────────────────────────────────────────

enum ExploreStatus { idle, loading, loadingMore, loaded, failure }

enum ExploreMode { list, map }

// ─── State ───────────────────────────────────────────────────────────────────

@freezed
abstract class ExploreState with _$ExploreState implements BaseBlocState {
  const factory ExploreState({
    // Map is the primary surface; the list is the filtered-results view.
    @Default(ExploreMode.map) ExploreMode mode,
    @Default(ExploreStatus.idle) ExploreStatus status,
    @Default(ExploreFilters()) ExploreFilters filters,
    @Default(<Event>[]) List<Event> items,
    @Default(1) int page,
    @Default(0) int total,
    @Default(<String>[]) List<String> recent,
    String? error,
    // Map mode (independent of the list so toggling doesn't clobber results).
    @Default(ExploreStatus.idle) ExploreStatus mapStatus,
    @Default(<Event>[]) List<Event> mapItems,
    String? mapError,
    double? centerLat,
    double? centerLng,
    String? city,
  }) = _ExploreState;

  const ExploreState._();

  bool get hasMore => items.length < total;
  bool get isFirstLoad => status == ExploreStatus.loading && items.isEmpty;
  bool get isEmptyResult => status == ExploreStatus.loaded && items.isEmpty;

  bool get hasCenter => centerLat != null && centerLng != null;
  bool get mapFirstLoad =>
      mapStatus == ExploreStatus.loading && mapItems.isEmpty;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class ExploreBloc extends BaseBloc<ExploreEvent, ExploreState> {
  ExploreBloc(this._search, this._nearby, this._recentStore, this._favorites)
    : super(const ExploreState()) {
    on<ExploreStarted>(_onStarted);
    on<ExploreQueryChanged>(
      _onQueryChanged,
      transformer: _debounceRestartable(const Duration(milliseconds: 350)),
    );
    on<ExploreSearchSubmitted>(_onSearchSubmitted);
    on<ExploreCategorySelected>(_onCategorySelected);
    on<ExploreSortChanged>(_onSortChanged);
    on<ExploreFiltersApplied>(_onFiltersApplied);
    on<ExploreLoadMore>(_onLoadMore);
    on<ExploreRefreshed>(_onRefreshed);
    on<ExploreCleared>(_onCleared);
    on<ExploreRecentCleared>(_onRecentCleared);
    on<ExploreModeToggled>(_onModeToggled);
    on<ExploreNearbyRequested>(_onNearbyRequested);
    on<ExploreLocationResolved>(_onLocationResolved);
  }

  final SearchEventsUseCase _search;
  final GetNearbyEventsUseCase _nearby;
  final RecentSearchesStore _recentStore;
  final FavoritesCubit _favorites;

  static const int _pageSize = 20;
  static const int _nearbyRadiusM = 20000;
  static const int _nearbyPageSize = 50;

  // Default event transformer is concurren, so two scroll trigger could overlap
  // This guards loadMore against double-fetching the same page.
  bool _loadingMore = false;

  Future<void> _onStarted(
    final ExploreStarted event,
    final Emitter<ExploreState> emit,
  ) async {
    // The page resolves the device location and dispatches locationResolved,
    // which loads the nearby feed. Here we only seed the recent searches.
    emit(state.copyWith(recent: _recentStore.read()));
  }

  /// Query/category changes refine whichever surface is active: in map mode
  /// they re-query the nearby feed, in list mode they re-run the search.
  Future<void> _applyFilterChange(
    final Emitter<ExploreState> emit,
    final ExploreFilters filters,
  ) async {
    if (state.mode == ExploreMode.map && state.hasCenter) {
      emit(state.copyWith(filters: filters));
      await _refreshNearby(emit, filters);
    } else {
      await _runSearch(emit, filters);
    }
  }

  Future<void> _onQueryChanged(
    final ExploreQueryChanged event,
    final Emitter<ExploreState> emit,
  ) => _applyFilterChange(emit, state.filters.copyWith(query: event.query));

  Future<void> _onSearchSubmitted(
    final ExploreSearchSubmitted event,
    final Emitter<ExploreState> emit,
  ) async {
    final List<String> recent = await _recentStore.add(event.query);
    emit(state.copyWith(recent: recent));
    await _applyFilterChange(emit, state.filters.copyWith(query: event.query));
  }

  Future<void> _onCategorySelected(
    final ExploreCategorySelected event,
    final Emitter<ExploreState> emit,
  ) => _applyFilterChange(
    emit,
    state.filters.copyWith(
      category: event.category,
      clearCategory: event.category == null,
    ),
  );

  // Sort and the advanced filter sheet (date/price/sort/city) are only honoured
  // by /events-search, so applying them switches to the list view.
  Future<void> _onSortChanged(
    final ExploreSortChanged event,
    final Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(mode: ExploreMode.list));
    await _runSearch(emit, state.filters.copyWith(sort: event.sort));
  }

  Future<void> _onFiltersApplied(
    final ExploreFiltersApplied event,
    final Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(mode: ExploreMode.list));
    await _runSearch(emit, event.filters);
  }

  Future<void> _onRefreshed(
    final ExploreRefreshed event,
    final Emitter<ExploreState> emit,
  ) async {
    if (state.mode == ExploreMode.map && state.hasCenter) {
      await _refreshNearby(emit, state.filters);
    } else {
      await _runSearch(emit, state.filters);
    }
  }

  Future<void> _onCleared(
    final ExploreCleared event,
    final Emitter<ExploreState> emit,
  ) => _applyFilterChange(emit, const ExploreFilters());

  Future<void> _onRecentCleared(
    final ExploreRecentCleared event,
    final Emitter<ExploreState> emit,
  ) async {
    final List<String> recent = await _recentStore.clear();
    emit(state.copyWith(recent: recent));
  }

  Future<void> _onModeToggled(
    final ExploreModeToggled event,
    final Emitter<ExploreState> emit,
  ) async {
    final ExploreMode next = state.mode == ExploreMode.list
        ? ExploreMode.map
        : ExploreMode.list;
    emit(state.copyWith(mode: next));
    if (next == ExploreMode.map && state.hasCenter) {
      await _refreshNearby(emit, state.filters);
    } else if (next == ExploreMode.list) {
      await _runSearch(emit, state.filters);
    }
  }

  Future<void> _onLoadMore(
    final ExploreLoadMore event,
    final Emitter<ExploreState> emit,
  ) async {
    if (_loadingMore ||
        !state.hasMore ||
        state.status == ExploreStatus.loading) {
      return;
    }

    _loadingMore = true;
    emit(state.copyWith(status: ExploreStatus.loadingMore));

    final int nextPage = state.page + 1;
    final result = await _search(
      SearchEventsParams(
        filters: state.filters,
        page: nextPage,
        pageSize: _pageSize,
      ),
    );

    result.fold(
      // keep what we have; the footer just stops spinning.
      (failure) => emit(state.copyWith(status: ExploreStatus.loaded)),
      (pageData) {
        _favorites.hydrateFromEvents(pageData.events);
        emit(
          state.copyWith(
            status: ExploreStatus.loaded,
            items: <Event>[...state.items, ...pageData.events],
            page: nextPage,
            total: pageData.total,
          ),
        );
      },
    );
    _loadingMore = false;
  }

  Future<void> _onNearbyRequested(
    final ExploreNearbyRequested event,
    final Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(centerLat: event.lat, centerLng: event.lng));
    await _refreshNearby(emit, state.filters);
  }

  Future<void> _onLocationResolved(
    final ExploreLocationResolved event,
    final Emitter<ExploreState> emit,
  ) async {
    emit(
      state.copyWith(
        mode: ExploreMode.map,
        centerLat: event.lat,
        centerLng: event.lng,
        city: event.city ?? state.city,
      ),
    );
    await _refreshNearby(emit, state.filters);
  }

  /// Reload the nearby feed for the current centre and [filters].
  Future<void> _refreshNearby(
    final Emitter<ExploreState> emit,
    final ExploreFilters filters,
  ) async {
    final double? lat = state.centerLat;
    final double? lng = state.centerLng;
    if (lat == null || lng == null) return;

    emit(state.copyWith(mapStatus: ExploreStatus.loading, mapError: null));
    final result = await _nearby(
      NearbyEventsParams(
        lat: lat,
        lng: lng,
        radiusM: _nearbyRadiusM,
        category: filters.category,
        query: filters.query,
        pageSize: _nearbyPageSize,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          mapStatus: ExploreStatus.failure,
          mapError: getErrorMessage(failure),
        ),
      ),
      (events) {
        _favorites.hydrateFromEvents(events);
        emit(state.copyWith(mapStatus: ExploreStatus.loaded, mapItems: events));
      },
    );
  }

  /// Fresh page-1 search; replaces the result list.
  Future<void> _runSearch(
    final Emitter<ExploreState> emit,
    final ExploreFilters filters,
  ) async {
    emit(
      state.copyWith(
        status: ExploreStatus.loading,
        filters: filters,
        page: 1,
        error: null,
      ),
    );
    final result = await _search(
      SearchEventsParams(filters: filters, page: 1, pageSize: _pageSize),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ExploreStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (pageData) {
        _favorites.hydrateFromEvents(pageData.events);
        emit(
          state.copyWith(
            status: ExploreStatus.loaded,
            items: pageData.events,
            page: 1,
            total: pageData.total,
            error: null,
          ),
        );
      },
    );
  }

  /// Debounce keystrokes, then restart — a new keystroke cancels the previous
  /// in-flight search (bloc ignores emits from the canceled handler).
  EventTransformer<E> _debounceRestartable<E>(final Duration duration) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}
