import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import '../repositories/explore_repository.dart';

class NearbyEventsParams extends Equatable {
  const NearbyEventsParams({
    required this.lat,
    required this.lng,
    this.radiusM = 20000,
    this.category,
    this.query,
    this.page = 1,
    this.pageSize = 50,
  });

  final double lat;
  final double lng;
  final int radiusM;
  final String? category;
  final String? query;
  final int page;
  final int pageSize;

  @override
  List<Object?> get props => <Object?>[
    lat,
    lng,
    radiusM,
    category,
    query,
    page,
    pageSize,
  ];
}

@lazySingleton
class GetNearbyEventsUseCase
    implements UseCase<List<Event>, NearbyEventsParams> {
  GetNearbyEventsUseCase(this._repository);

  final ExploreRepository _repository;

  @override
  EitherFailure<List<Event>> call(final NearbyEventsParams params) =>
      _repository.nearby(
        lat: params.lat,
        lng: params.lng,
        radiusM: params.radiusM,
        category: params.category,
        query: params.query,
        page: params.page,
        pageSize: params.pageSize,
      );
}
