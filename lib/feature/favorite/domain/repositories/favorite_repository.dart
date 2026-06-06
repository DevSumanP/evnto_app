import 'package:dartz/dartz.dart';
import 'package:tap_app/core/base/base_repository.dart';

import '../../../home/domain/entities/event_entity.dart';

abstract class FavoriteRepository {
  /// Toggle the caller's favorite state for [eventId].
  /// Backend is idempotent both ways, so retries with the same value
  /// are safe.
  EitherFailure<Unit> toggleFavorite({
    required String eventId,
    required bool favorite,
  });

  /// Caller's saved events, newest first. Same row shape as the discover
  /// feed, so the same Event entity is reused.
  EitherFailure<List<Event>> getFavorites({int page = 1, int pageSize = 20});
}
