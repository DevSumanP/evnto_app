import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/tickets/domain/entities/ticket_entity.dart';

abstract class TicketRepository {
  EitherFailure<List<TicketEntity>> getMyTickets();
  EitherFailure<TicketQREntity> getMyTicketQR({required String ticketId});
}
