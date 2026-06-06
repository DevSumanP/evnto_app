import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/checkout_initiate_model.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/checkout_session.dart';
import '../../domain/entities/issued_ticket.dart';
import '../../domain/usecases/initiate_checkout_use_case.dart';
import '../../domain/usecases/verify_checkout_use_case.dart';

part 'checkout_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class CheckoutEvent with _$CheckoutEvent implements BaseBlocEvent {
  const factory CheckoutEvent.started({
    required String eventId,
    required List<CartItem> items,
    required BuyerDto buyer,
  }) = CheckoutStarted;

  const factory CheckoutEvent.placeOrderTapped() = CheckoutPlaceOrderTapped;

  const factory CheckoutEvent.verifyRequested({
    required String orderId,
    required String pidx,
  }) = CheckoutVerifyRequested;

  const factory CheckoutEvent.paymentCanceled() = CheckoutPaymentCanceled;
}

// ─── Status ──────────────────────────────────────────────────────────────────
enum CheckoutStatus { idle, initiating, ready, verifying, succeeded, failure }

// ─── State ───────────────────────────────────────────────────────────────────
@freezed
abstract class CheckoutState with _$CheckoutState implements BaseBlocState {
  const factory CheckoutState({
    @Default('') String eventId,
    @Default(<CartItem>[]) List<CartItem> items,
    BuyerDto? buyer,
    @Default(CheckoutStatus.idle) CheckoutStatus status,
    CheckoutSession? session,
    @Default(<IssuedTicket>[]) List<IssuedTicket> tickets,
    String? error,
  }) = _CheckoutState;

  const CheckoutState._();

  bool get isInitiating => status == CheckoutStatus.initiating;
  bool get isReady => status == CheckoutStatus.ready && session != null;
  bool get isVerifying => status == CheckoutStatus.verifying;
  bool get hasSucceeded => status == CheckoutStatus.succeeded;
  bool get hasFailed => status == CheckoutStatus.failure;

  int get subtotalPaisa =>
      items.fold<int>(0, (sum, i) => sum + i.lineTotalPaisa);

  /// v1: fees are zero. Row is kept so layout doesn't shift later.
  int get feesPaisa => 0;

  int get totalPaisa => subtotalPaisa + feesPaisa;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class CheckoutBloc extends BaseBloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(this._initiate, this._verify) : super(const CheckoutState()) {
    on<CheckoutStarted>(_onStarted);
    on<CheckoutPlaceOrderTapped>(_onPlaceOrder);
    on<CheckoutVerifyRequested>(_onVerify);
    on<CheckoutPaymentCanceled>(_onCanceled);
  }

  final InitiateCheckoutUseCase _initiate;
  final VerifyCheckoutUseCase _verify;
  static const Uuid _uuid = Uuid();

  void _onStarted(final CheckoutStarted e, final Emitter<CheckoutState> emit) {
    emit(
      state.copyWith(
        eventId: e.eventId,
        items: e.items,
        buyer: e.buyer,
        status: CheckoutStatus.idle,
        session: null,
        error: null,
      ),
    );
  }

  Future<void> _onPlaceOrder(
    final CheckoutPlaceOrderTapped e,
    final Emitter<CheckoutState> emit,
  ) async {
    if (state.isInitiating) return;
    if (state.items.isEmpty || state.buyer == null) return;

    emit(state.copyWith(status: CheckoutStatus.initiating, error: null));

    final request = CheckoutInitiateRequest(
      eventId: state.eventId,
      items: state.items
          .map(
            (i) => CheckoutLineItemDto(tierId: i.tier.id, quantity: i.quantity),
          )
          .toList(growable: false),
      buyer: state.buyer!,
    );

    final result = await _initiate(
      InitiateCheckoutParams(request: request, idempotencyKey: _uuid.v4()),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (session) => emit(
        state.copyWith(
          status: CheckoutStatus.ready,
          session: session,
          error: null,
        ),
      ),
    );
  }

  Future<void> _onVerify(
    final CheckoutVerifyRequested e,
    final Emitter<CheckoutState> emit,
  ) async {
    if (state.isVerifying) return;
    emit(state.copyWith(status: CheckoutStatus.verifying, error: null));

    final result = await _verify(
      VerifyCheckoutParams(orderId: e.orderId, pidx: e.pidx),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (tickets) => emit(
        state.copyWith(
          status: CheckoutStatus.succeeded,
          tickets: tickets,
          error: null,
        ),
      ),
    );
  }

  // Drop the session so the user can re-initiate from Order Review. Server
  // auto-releases seats after the 10-minute hold expires; no client cleanup
  // needed.
  void _onCanceled(
    final CheckoutPaymentCanceled e,
    final Emitter<CheckoutState> emit,
  ) {
    emit(
      state.copyWith(status: CheckoutStatus.idle, session: null, error: null),
    );
  }
}
