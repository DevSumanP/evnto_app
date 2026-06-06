import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

abstract class HomeRepository {
  EitherFailure<List<Event>> getUpcomingEvents({int pageSize = 10});

  EitherFailure<List<Event>> getPopularEvents({int pageSize = 10});

  EitherFailure<List<Event>> getSuggestedEvents({
    required String city,
    int pageSize = 10,
  });
}
