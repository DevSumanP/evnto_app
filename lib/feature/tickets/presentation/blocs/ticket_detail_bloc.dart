import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';

import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/get_my_ticket_qr_use_case.dart';

part 'ticket_detail_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class TicketDetailEvent with _$TicketDetailEvent implements BaseBlocEvent {
  const factory TicketDetailEvent.started(String ticketId) =
      TicketDetailStarted;
  const factory TicketDetailEvent.refreshed() = TicketDetailRefreshed;
}

// ─── Status ──────────────────────────────────────────────────────────────────
enum TicketDetailStatus { idle, loading, loaded, failure }

// ─── State ───────────────────────────────────────────────────────────────────
@freezed
abstract class TicketDetailState
    with _$TicketDetailState
    implements BaseBlocState {
  const factory TicketDetailState({
    @Default('') String ticketId,
    @Default(TicketDetailStatus.idle) TicketDetailStatus status,
    TicketQREntity? qr,
    String? error,
  }) = _TicketDetailState;

  const TicketDetailState._();

  bool get isLoading => status == TicketDetailStatus.loading;
  bool get hasLoaded => status == TicketDetailStatus.loaded && qr != null;
  bool get hasFailed => status == TicketDetailStatus.failure;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class TicketDetailBloc extends BaseBloc<TicketDetailEvent, TicketDetailState> {
  TicketDetailBloc(this._getTicketQr) : super(const TicketDetailState()) {
    on<TicketDetailStarted>(_onStarted);
    on<TicketDetailRefreshed>(_onRefreshed);
  }

  final GetTicketQrUseCase _getTicketQr;

  Future<void> _onStarted(
    final TicketDetailStarted e,
    final Emitter<TicketDetailState> emit,
  ) async {
    emit(state.copyWith(ticketId: e.ticketId));
    await _fetch(emit, e.ticketId);
  }

  Future<void> _onRefreshed(
    final TicketDetailRefreshed e,
    final Emitter<TicketDetailState> emit,
  ) async {
    final id = state.ticketId;
    if (id.isEmpty) return;
    await _fetch(emit, id);
  }

  Future<void> _fetch(
    final Emitter<TicketDetailState> emit,
    final String ticketId,
  ) async {
    emit(state.copyWith(status: TicketDetailStatus.loading, error: null));

    final result = await _getTicketQr(GetTicketQrParams(ticketId: ticketId));
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TicketDetailStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (qr) => emit(
        state.copyWith(status: TicketDetailStatus.loaded, qr: qr, error: null),
      ),
    );
  }
}
