import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import '../../domain/entities/checkout_session.dart';
import '../../domain/entities/issued_ticket.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_remote_data_source.dart';
import '../models/checkout_initiate_model.dart';

@LazySingleton(as: CheckoutRepository)
class CheckoutRepositoryImpl extends BaseRepository
    implements CheckoutRepository {
  const CheckoutRepositoryImpl(this._remote);
  final CheckoutRemoteDataSource _remote;

  @override
  EitherFailure<CheckoutSession> initiate({
    required CheckoutInitiateRequest request,
    required String idempotencyKey,
  }) => execute(
    operation: () async {
      final model = await _remote.initiate(
        request: request,
        idempotencyKey: idempotencyKey,
      );
      return model.toEntity();
    },
  );

  @override
  EitherFailure<List<IssuedTicket>> verify({
    required String orderId,
    required String pidx,
  }) => execute(
    operation: () async {
      final model = await _remote.verify(orderId: orderId, pidx: pidx);
      return model.toEntities();
    },
  );
}
