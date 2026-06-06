import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/feature/home/domain/repositories/home_repository.dart';

class GetSuggestedEventParams extends Equatable {
  const GetSuggestedEventParams({required this.city});

  final String city;

  @override
  List<Object?> get props => [city];
}

@lazySingleton
class GetSuggestedEventUseCase
    implements UseCase<List<Event>, GetSuggestedEventParams> {
  GetSuggestedEventUseCase(this._repository);

  final HomeRepository _repository;

  @override
  EitherFailure<List<Event>> call(final GetSuggestedEventParams params) =>
      _repository.getSuggestedEvents(city: params.city, pageSize: 10);
}
