import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import '../entities/checkout_session.dart';
import '../repositories/checkout_repository.dart';
import '../../data/models/checkout_initiate_model.dart';

class InitiateCheckoutParams extends Equatable {
  const InitiateCheckoutParams({
    required this.request,
    required this.idempotencyKey,
  });

  final CheckoutInitiateRequest request;
  final String idempotencyKey;

  @override
  List<Object?> get props => [idempotencyKey, request.eventId];
}

@lazySingleton
class InitiateCheckoutUseCase
    implements UseCase<CheckoutSession, InitiateCheckoutParams> {
  const InitiateCheckoutUseCase(this._repo);
  final CheckoutRepository _repo;

  @override
  EitherFailure<CheckoutSession> call(InitiateCheckoutParams params) => _repo
      .initiate(request: params.request, idempotencyKey: params.idempotencyKey);
}
