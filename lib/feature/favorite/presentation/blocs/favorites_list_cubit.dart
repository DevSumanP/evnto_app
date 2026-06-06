import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/errors/error_handler.dart';
import 'package:tap_app/feature/favorite/domain/usecases/get_favorite_use_case.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_cubit.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

enum FavoritesListStatus { idle, loading, loaded, failure }

class FavoritesListState extends Equatable {
  const FavoritesListState({
    this.status = FavoritesListStatus.idle,
    this.items = const <Event>[],
    this.error,
  });

  final FavoritesListStatus status;
  final List<Event> items;
  final String? error;

  bool get isLoading => status == FavoritesListStatus.loading;
  bool get hasFailed => status == FavoritesListStatus.failure;
  bool get hasLoaded => status == FavoritesListStatus.loaded;
  bool get isEmpty => hasLoaded && items.isEmpty;

  FavoritesListState copyWith({
    FavoritesListStatus? status,
    List<Event>? items,
    String? error,
  }) => FavoritesListState(
    status: status ?? this.status,
    items: items ?? this.items,
    error: error,
  );

  @override
  List<Object?> get props => [status, items, error];
}

@injectable
class FavoritesListCubit extends Cubit<FavoritesListState> {
  FavoritesListCubit(this._getFavorites, this._favortiesCubit)
    : super(const FavoritesListState()) {
    // Listen to the global cubit so un-favoriting (here or anywhere else)
    // removes the row locally without a network round-trip.
    _favSub = _favortiesCubit.stream.listen(_onGlobalFavoritesChanged);
  }

  final GetFavoritesUseCase _getFavorites;
  final FavoritesCubit _favortiesCubit;

  late final StreamSubscription<FavoritesState> _favSub;

  /// Pure optimistic reconciliation. When the global favorited set changes,
  /// drop any items here whose id is no longer favorited. We do NOT
  /// auto-fetch new additions — that would require a network call on every
  /// toggle. To pick up favorites added elsewhere, the user pulls to refresh.
  void _onGlobalFavoritesChanged(final FavoritesState s) {
    if (!state.hasLoaded) return;
    final Set<String> nowFavorited = s.favoritedIds;
    final List<Event> kept = state.items
        .where((final Event e) => nowFavorited.contains(e.id))
        .toList(growable: false);
    if (kept.length == state.items.length) return;
    emit(state.copyWith(items: kept));
  }

  Future<void> load() async {
    emit(state.copyWith(status: FavoritesListStatus.loading, error: null));
    final result = await _getFavorites(const GetFavoritesParams(pageSize: 50));
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FavoritesListStatus.failure,
          error: ErrorHandler.instance.getUserMessage(failure),
        ),
      ),
      (events) {
        // Keep the global cubit in sync with what we just renderd.
        _favortiesCubit.hydrateFromEvents(events);
        emit(
          state.copyWith(
            status: FavoritesListStatus.loaded,
            items: events,
            error: null,
          ),
        );
      },
    );
  }

  Future<void> refresh() => load();

  @override
  Future<void> close() async {
    await _favSub.cancel();
    return super.close();
  }
}
