import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/core/utils/usecase.dart';

import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/get_my_tickets_use_case.dart';

part 'tickets_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class TicketsEvent with _$TicketsEvent implements BaseBlocEvent {
  const factory TicketsEvent.started() = TicketsStarted;
  const factory TicketsEvent.refreshed() = TicketsRefreshed;
}

// ─── Status ──────────────────────────────────────────────────────────────────
enum TicketsStatus { idle, loading, loaded, failure }

// ─── State ───────────────────────────────────────────────────────────────────
@freezed
abstract class TicketsState with _$TicketsState implements BaseBlocState {
  const factory TicketsState({
    @Default(TicketsStatus.idle) TicketsStatus status,
    @Default(<TicketEntity>[]) List<TicketEntity> tickets,
    String? error,
  }) = _TicketsState;

  const TicketsState._();

  bool get isLoading => status == TicketsStatus.loading;
  bool get hasLoaded => status == TicketsStatus.loaded;
  bool get hasFailed => status == TicketsStatus.failure;

  /// True when the user has bought tickets but the list is empty for some
  /// other reason (refund cleared everything, etc.). Useful for the
  /// "no tickets yet" state in the page.
  bool get isEmpty => hasLoaded && tickets.isEmpty;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class TicketsBloc extends BaseBloc<TicketsEvent, TicketsState> {
  TicketsBloc(this._getMyTickets) : super(const TicketsState()) {
    on<TicketsStarted>(_onStarted);
    on<TicketsRefreshed>(_onRefreshed);
  }

  final GetMyTicketsUseCase _getMyTickets;

  Future<void> _onStarted(
    final TicketsStarted e,
    final Emitter<TicketsState> emit,
  ) async {
    // Skip if we already have data — the page rebuilds frequently when the
    // tab is reselected; pull-to-refresh covers the staleness case.
    if (state.hasLoaded) return;
    await _load(emit);
  }

  Future<void> _onRefreshed(
    final TicketsRefreshed e,
    final Emitter<TicketsState> emit,
  ) => _load(emit);

  Future<void> _load(final Emitter<TicketsState> emit) async {
    emit(state.copyWith(status: TicketsStatus.loading, error: null));

    final result = await _getMyTickets(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TicketsStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (tickets) => emit(
        state.copyWith(
          status: TicketsStatus.loaded,
          tickets: tickets,
          error: null,
        ),
      ),
    );
  }
}
