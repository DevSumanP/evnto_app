import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/event-detail/data/datasources/event_detail_remote_data_Source.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';
import 'package:tap_app/feature/event-detail/domain/repositories/event_detail_repository.dart';

@LazySingleton(as: EventDetailRepository)
class EventDetailRepositoryImpl extends BaseRepository
    implements EventDetailRepository {
  const EventDetailRepositoryImpl(this._remote);

  final EventDetailRemoteDataSource _remote;

  @override
  EitherFailure<EventDetail> getEventDetail({required String eventId}) =>
      execute(
        operation: () async {
          final model = await _remote.getEventDetail(eventId: eventId);
          return model.toEntity();
        },
      );
}
