import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import '../entities/issued_ticket.dart';
import '../repositories/checkout_repository.dart';

class VerifyCheckoutParams extends Equatable {
  const VerifyCheckoutParams({required this.orderId, required this.pidx});
  final String orderId;
  final String pidx;
  @override
  List<Object?> get props => [orderId, pidx];
}

@lazySingleton
class VerifyCheckoutUseCase
    implements UseCase<List<IssuedTicket>, VerifyCheckoutParams> {
  const VerifyCheckoutUseCase(this._repo);
  final CheckoutRepository _repo;

  @override
  EitherFailure<List<IssuedTicket>> call(VerifyCheckoutParams params) =>
      _repo.verify(orderId: params.orderId, pidx: params.pidx);
}
