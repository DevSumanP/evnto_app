import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import '../entities/ticket_entity.dart';
import '../repositories/ticket_repository.dart';

class GetTicketQrParams extends Equatable {
  const GetTicketQrParams({required this.ticketId});

  final String ticketId;

  @override
  List<Object?> get props => <Object?>[ticketId];
}

@lazySingleton
class GetTicketQrUseCase
    implements UseCase<TicketQREntity, GetTicketQrParams> {
  const GetTicketQrUseCase(this._repo);

  final TicketRepository _repo;

  @override
  EitherFailure<TicketQREntity> call(final GetTicketQrParams params) =>
      _repo.getMyTicketQR(ticketId: params.ticketId);
}
