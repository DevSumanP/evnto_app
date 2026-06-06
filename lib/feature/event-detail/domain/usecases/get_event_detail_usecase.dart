import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';
import 'package:tap_app/feature/event-detail/domain/repositories/event_detail_repository.dart';

class GetEventDetailParams extends Equatable {
  const GetEventDetailParams({required this.eventId});

  final String eventId;

  @override
  List<Object?> get props => [eventId];
}

@lazySingleton
class GetEventDetailUsecase
    implements UseCase<EventDetail, GetEventDetailParams> {
  const GetEventDetailUsecase(this._repository);

  final EventDetailRepository _repository;

  @override
  EitherFailure<EventDetail> call(GetEventDetailParams params) =>
      _repository.getEventDetail(eventId: params.eventId);
}
