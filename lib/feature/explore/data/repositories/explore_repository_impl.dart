import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/explore/domain/entities/event_search_page.dart';
import 'package:tap_app/feature/explore/domain/entities/explore_filters.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

import '../../domain/repositories/explore_repository.dart';
import '../datasources/explore_remote_data_source.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl extends BaseRepository
    implements ExploreRepository {
  ExploreRepositoryImpl(this._remote);

  final ExploreRemoteDataSource _remote;

  @override
  EitherFailure<EventSearchPage> search(
    ExploreFilters filters, {
    int page = 1,
    int pageSize = 20,
  }) => execute(
    operation: () async {
      final result = await _remote.search(
        filters.toQuery(page: page, pageSize: pageSize),
      );

      return EventSearchPage(
        events: result.events
            .map((event) => event.toEntity())
            .toList(growable: false),
        total: result.total,
      );
    },
  );

  @override
  EitherFailure<List<Event>> nearby({
    required final double lat,
    required final double lng,
    final int radiusM = 20000,
    final String? category,
    final String? query,
    final int page = 1,
    final int pageSize = 50,
  }) => execute(
    operation: () async {
      final models = await _remote.nearby(<String, dynamic>{
        'lat': lat,
        'lng': lng,
        'radius_m': radiusM,
        if (category != null) 'category': category,
        if (query != null && query.trim().isNotEmpty) 'q': query.trim(),
        'page': page,
        'page_size': pageSize,
      });
      return models.map((m) => m.toEntity()).toList(growable: false);
    },
  );
}
