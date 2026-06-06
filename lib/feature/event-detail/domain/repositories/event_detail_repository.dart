import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';

abstract class EventDetailRepository {
  /// Fetch a single repository by its id from /event-get
  /// Returns Left(NotFoundFailure) when the event does not exist.
  EitherFailure<EventDetail> getEventDetail({required String eventId});
}
