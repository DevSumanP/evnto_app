import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/favorite/data/datasources/favorite_remote_data_source.dart';
import 'package:tap_app/feature/favorite/domain/repositories/favorite_repository.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl extends BaseRepository
    implements FavoriteRepository {
  FavoriteRepositoryImpl(this._remote);

  final FavoriteRemoteDataSource _remote;

  @override
  EitherFailure<List<Event>> getFavorites({int page = 1, int pageSize = 20}) =>
      execute(
        operation: () async {
          final models = await _remote.listFavorite(
            page: page,
            pageSize: pageSize,
          );
          return models.map((m) => m.toEntity()).toList(growable: false);
        },
      );

  @override
  EitherFailure<Unit> toggleFavorite({
    required String eventId,
    required bool favorite,
  }) => executeVoid(
    operation: () =>
        _remote.toggleFavorite(eventId: eventId, favorite: favorite),
  );
}
