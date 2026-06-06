import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/explore/domain/entities/event_search_page.dart';
import 'package:tap_app/feature/explore/domain/entities/explore_filters.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

abstract class ExploreRepository {
  /// One page of search results for [filters]. Backed by /events-search.
  EitherFailure<EventSearchPage> search(
    ExploreFilters filters, {
    int page = 1,
    int pageSize = 20,
  });

  /// Events near a coordinate, for the map / "near me" mode.
  /// backed by /events-nearby (which has no total count, so it returns a plain list).
  EitherFailure<List<Event>> nearby({
    required double lat,
    required double lng,
    int radiusM = 20000,
    String? category,
    String? query,
    int page = 1,
    int pageSize = 50,
  });
}
