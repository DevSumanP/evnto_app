import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:tap_app/feature/tickets/domain/entities/ticket_entity.dart';
import 'package:tap_app/feature/tickets/domain/repositories/ticket_repository.dart';

@LazySingleton(as: TicketRepository)
class TicketRepositoryImpl extends BaseRepository implements TicketRepository {
  const TicketRepositoryImpl(this._remote);
  final TicketRemoteDataSource _remote;

  @override
  EitherFailure<TicketQREntity> getMyTicketQR({required String ticketId}) =>
      execute(
        operation: () async {
          final model = await _remote.getMyTicketQR(ticketId: ticketId);
          return model.toEntity();
        },
      );

  @override
  EitherFailure<List<TicketEntity>> getMyTickets() => execute(
    operation: () async {
      final models = await _remote.getMyTickets();
      return models.map((m) => m.toEntity()).toList(growable: false);
    },
  );
}
