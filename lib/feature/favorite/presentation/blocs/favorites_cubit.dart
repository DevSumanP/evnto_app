// ==============================================================================
// lib/feature/favorite/presentation/blocs/favorites_cubit.dart
// Cross-feature source of truth for which events the caller has saved.
//
// Lifecycle:
//   - Constructed once (LazySingleton). Self-seeds via getFavorites().
//   - Listens to AuthSessionService.events; clears on sign-out / expiry.
//
// Toggle semantics:
//   - Flip locally first, then call the API.
//   - If the same id is already in-flight, coalesce to the latest desired
//     state — don't queue duplicates.
//   - On API failure, revert and surface an error via the [errors] stream.
// ==============================================================================

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/errors/failures.dart';
import 'package:tap_app/core/services/auth_session_service.dart';
import 'package:tap_app/core/utils/logger.dart';
import 'package:tap_app/feature/favorite/domain/usecases/toggle_favorite_use_case.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

import '../../domain/usecases/get_favorite_use_case.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoritedIds = const <String>{},
    this.pending = const <String>{},
  });

  /// Event ids the caller has saved.
  final Set<String> favoritedIds;

  /// Toggles that are currently round-tripping. Used to coalesce rapid taps
  /// and to protect optimistic state from being overwritten by hydration.
  final Set<String> pending;

  bool contains(final String eventId) => favoritedIds.contains(eventId);
  bool isPending(final String eventId) => pending.contains(eventId);

  FavoritesState copyWith({Set<String>? favoritedIds, Set<String>? pending}) =>
      FavoritesState(
        favoritedIds: favoritedIds ?? this.favoritedIds,
        pending: pending ?? this.pending,
      );

  @override
  List<Object?> get props => <Object?>[favoritedIds, pending];
}

@lazySingleton
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._getFavorites, this._toggleFavorite, this._session)
    : super(const FavoritesState()) {
    _sessionSub = _session.events.listen(_onSessionEvent);
    // Fire and forget — failures (e.g. anonymous caller) leave the set empty,
    // which is the correct initial state.
    unawaited(loadInitial());
  }

  final GetFavoritesUseCase _getFavorites;
  final ToggleFavoriteUseCase _toggleFavorite;
  final AuthSessionService _session;

  final StreamController<FavoritesError> _errors =
      StreamController<FavoritesError>.broadcast();

  /// Errors the UI can subscribe to for snackbars.
  Stream<FavoritesError> get errors => _errors.stream;

  late final StreamSubscription<SessionEvent> _sessionSub;

  /// Latest desired value per id while a toggle is in flight. Used to coalesce
  /// rapid taps — the in-flight request finishes, then we replay the latest
  /// desired state if it disagrees with the server response.
  final Map<String, bool> _latestDesired = <String, bool>{};

  /// Seed the cubit from the server. Safe to call multiple times.
  Future<void> loadInitial() async {
    final result = await _getFavorites(const GetFavoritesParams(pageSize: 200));
    result.fold(
      (failure) {
        // Anonymous callers get UnauthorizedFailure — that is expected and
        // not an error to surface.
        if (failure is! UnauthorizedFailure) {
          AppLogger.instance.warning(
            'Failed to seed favorites: ${failure.message}',
            category: 'FavoritesCubit',
          );
        }
      },
      (events) {
        final ids = events.map((e) => e.id).toSet();
        // Don't clobber optimistic in-flight state.
        ids.addAll(state.favoritedIds.where(state.isPending));
        emit(state.copyWith(favoritedIds: ids));
      },
    );
  }

  /// Update the cubit from a single freshly-loaded detail row. Same rules as
  /// [hydrateFromEvents]: skips ids with a pending toggle so optimistic UI
  /// is not clobbered.
  void hydrateOne(final String eventId, final bool isFavorited) {
    if (state.isPending(eventId)) return;
    final next = Set<String>.from(state.favoritedIds);
    if (isFavorited) {
      next.add(eventId);
    } else {
      next.remove(eventId);
    }
    if (next.length == state.favoritedIds.length &&
        next.containsAll(state.favoritedIds)) {
      return;
    }
    emit(state.copyWith(favoritedIds: next));
  }

  /// Update the cubit from a freshly loaded list. Adds ids whose
  /// [Event.isFavorited] is true, removes those that are false. Skips any id
  /// with a pending toggle so optimistic UI is not clobbered.
  void hydrateFromEvents(final Iterable<Event> events) {
    final next = Set<String>.from(state.favoritedIds);
    for (final e in events) {
      if (state.isPending(e.id)) continue;
      if (e.isFavorited) {
        next.add(e.id);
      } else {
        next.remove(e.id);
      }
    }
    if (next.length == state.favoritedIds.length &&
        next.containsAll(state.favoritedIds)) {
      return;
    }
    emit(state.copyWith(favoritedIds: next));
  }

  /// Flip the saved state for [eventId]. Optimistic; reverts on failure.
  Future<void> toggle(final String eventId) async {
    final bool desired = !state.contains(eventId);
    _latestDesired[eventId] = desired;

    // If something is already in flight for this id, the running task picks
    // up _latestDesired after it returns — don't start a second request.
    if (state.isPending(eventId)) {
      _applyOptimistic(eventId, desired);
      return;
    }

    _applyOptimistic(eventId, desired);
    emit(state.copyWith(pending: <String>{...state.pending, eventId}));

    await _drain(eventId);
  }

  Future<void> _drain(final String eventId) async {
    while (_latestDesired.containsKey(eventId)) {
      final bool desired = _latestDesired.remove(eventId)!;
      final result = await _toggleFavorite(
        ToggleFavoriteParams(eventId: eventId, favorite: desired),
      );
      result.fold(
        (failure) {
          // Revert to server state on failure. We assume server state is the
          // opposite of `desired` since the call failed.
          _applyOptimistic(eventId, !desired);
          _errors.add(FavoritesError(eventId: eventId, failure: failure));
        },
        (_) {
          // Success — local state already matches desired.
        },
      );
    }
    final next = Set<String>.from(state.pending)..remove(eventId);
    emit(state.copyWith(pending: next));
  }

  void _applyOptimistic(final String eventId, final bool favorite) {
    final next = Set<String>.from(state.favoritedIds);
    if (favorite) {
      next.add(eventId);
    } else {
      next.remove(eventId);
    }
    emit(state.copyWith(favoritedIds: next));
  }

  void _onSessionEvent(final SessionEvent event) {
    // Either expiry or explicit sign-out wipes saved state.
    _latestDesired.clear();
    emit(const FavoritesState());
  }

  @override
  Future<void> close() async {
    await _sessionSub.cancel();
    await _errors.close();
    return super.close();
  }
}

class FavoritesError {
  const FavoritesError({required this.eventId, required this.failure});

  final String eventId;
  final Failure failure;
}
