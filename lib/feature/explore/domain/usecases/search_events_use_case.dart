import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/explore/domain/entities/explore_filters.dart';
import 'package:tap_app/feature/explore/domain/repositories/explore_repository.dart';

import '../entities/event_search_page.dart';

class SearchEventsParams extends Equatable {
  const SearchEventsParams({
    required this.filters,
    this.page = 1,
    this.pageSize = 20,
  });

  final ExploreFilters filters;
  final int page;
  final int pageSize;

  @override
  List<Object?> get props => [filters, page, pageSize];
}

@lazySingleton
class SearchEventsUseCase
    implements UseCase<EventSearchPage, SearchEventsParams> {
  SearchEventsUseCase(this._repository);

  final ExploreRepository _repository;

  @override
  EitherFailure<EventSearchPage> call(final SearchEventsParams params) =>
      _repository.search(
        params.filters,
        page: params.page,
        pageSize: params.pageSize,
      );
}
