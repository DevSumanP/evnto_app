import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/feature/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetPopularEventsUseCase implements UseCase<List<Event>, NoParams> {
  GetPopularEventsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  EitherFailure<List<Event>> call(final NoParams params) =>
      _repository.getPopularEvents(pageSize: 10);
}
