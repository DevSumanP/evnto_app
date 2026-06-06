import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/tickets/domain/entities/ticket_entity.dart';
import 'package:tap_app/feature/tickets/domain/repositories/ticket_repository.dart';

@lazySingleton
class GetMyTicketsUseCase implements UseCase<List<TicketEntity>, NoParams> {
  const GetMyTicketsUseCase(this._repository);

  final TicketRepository _repository;

  @override
  EitherFailure<List<TicketEntity>> call(final NoParams params) =>
      _repository.getMyTickets();
}
