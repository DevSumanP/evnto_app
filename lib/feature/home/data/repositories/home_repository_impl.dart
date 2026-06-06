import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/home/data/datasources/home_remote_data_source.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/feature/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends BaseRepository implements HomeRepository {
  HomeRepositoryImpl(this._remote);

  final HomeRemoteDataSource _remote;

  @override
  EitherFailure<List<Event>> getUpcomingEvents({int pageSize = 10}) => execute(
    operation: () async {
      final nowIso = DateTime.now().toUtc().toIso8601String();
      final models = await _remote.getEvents(from: nowIso, pageSize: pageSize);
      return models.map((m) => m.toEntity()).toList(growable: false);
    },
  );

  @override
  EitherFailure<List<Event>> getPopularEvents({int pageSize = 10}) => execute(
    operation: () async {
      final models = await _remote.getEvents(pageSize: pageSize);
      return models.map((m) => m.toEntity()).toList(growable: false);
    },
  );

  @override
  EitherFailure<List<Event>> getSuggestedEvents({
    required String city,
    int pageSize = 10,
  }) => execute(
    operation: () async {
      final models = await _remote.getEvents(city: city, pageSize: pageSize);
      return models.map((m) => m.toEntity()).toList(growable: false);
    },
  );
}
