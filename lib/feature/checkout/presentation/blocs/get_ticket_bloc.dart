import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/auth/domain/entities/current_user.dart';
import 'package:tap_app/feature/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';

import '../../domain/entities/cart_item.dart';

part 'get_ticket_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────

@freezed
class GetTicketEvent with _$GetTicketEvent implements BaseBlocEvent {
  const factory GetTicketEvent.started({
    required String eventId,
    required List<TicketTier> tiers,
  }) = GetTicketStarted;

  const factory GetTicketEvent.incremented(String tierId) =
      GetTicketIncremented;

  const factory GetTicketEvent.decremented(String tierId) =
      GetTicketDecremented;

  const factory GetTicketEvent.cleared() = GetTicketCleared;
}

// ─── State ───────────────────────────────────────────────────────────────────
@freezed
abstract class GetTicketState with _$GetTicketState implements BaseBlocState {
  const factory GetTicketState({
    @Default('') String eventId,
    @Default(<TicketTier>[]) List<TicketTier> tiers,
    @Default(<String, int>{}) Map<String, int> quantities,
    CurrentUser? buyer,
  }) = _GetTicketState;

  const GetTicketState._();

  static const int kMaxPerTier = 20;
  static const int kMaxLineItems = 10;

  /// Cart rows, in tier sortOrder.
  List<CartItem> get items => tiers
      .where((t) => (quantities[t.id] ?? 0) > 0)
      .map((t) => CartItem(tier: t, quantity: quantities[t.id]!))
      .toList(growable: false);

  int get totalQuantity => quantities.values.fold<int>(0, (a, b) => a + b);

  int get subtotalPaisa =>
      items.fold<int>(0, (sum, item) => sum + item.lineTotalPaisa);

  /// True when the cart has at least one row AND we have a buyer to put on
  /// the order. The buyer is fetched once from /auth/v1/user on started.
  bool get canPlaceOrder => items.isNotEmpty && buyer != null;

  /// Effective cap for one tier — respects both the tier's remaining count
  /// and the global per-tier hard cap.
  int capFor(TicketTier tier) {
    final int remaining = tier.quantityRemaining;
    return remaining < kMaxPerTier ? remaining : kMaxPerTier;
  }
}

// ─── Bloc ────────────────────────────────────────────────────────────────────
@injectable
class GetTicketBloc extends BaseBloc<GetTicketEvent, GetTicketState> {
  GetTicketBloc(this._getCurrentUser) : super(const GetTicketState()) {
    on<GetTicketStarted>(_onStarted);
    on<GetTicketIncremented>(_onIncremented);
    on<GetTicketDecremented>(_onDecremented);
    on<GetTicketCleared>(_onCleared);
  }

  final GetCurrentUserUseCase _getCurrentUser;

  Future<void> _onStarted(
    final GetTicketStarted e,
    final Emitter<GetTicketState> emit,
  ) async {
    // Only seed once. If tiers reload (e.g. retry), keep existing quantities
    // but drop any that point at a tier that no longer exists.
    final Set<String> validIds = e.tiers.map((t) => t.id).toSet();
    final Map<String, int> reconciled = <String, int>{
      for (final entry in state.quantities.entries)
        if (validIds.contains(entry.key)) entry.key: entry.value,
    };

    emit(
      state.copyWith(
        eventId: e.eventId,
        tiers: e.tiers,
        quantities: reconciled,
      ),
    );

    // Pull the signed-in user for the buyer block on Order Review. If this
    // fails we keep the Continue button disabled rather than crashing — a
    // visible error here would be noisy for a screen the user is just
    // browsing.
    if (state.buyer != null) return;
    final result = await _getCurrentUser(const NoParams());
    result.fold(
      (_) {},
      (user) => emit(state.copyWith(buyer: user)),
    );
  }

  void _onIncremented(
    final GetTicketIncremented e,
    final Emitter<GetTicketState> emit,
  ) {
    final TicketTier? tier = _tier(e.tierId);
    if (tier == null) return;
    if (!tier.isOnSale) return;

    final int current = state.quantities[e.tierId] ?? 0;

    // Adding a brand-new line — respect the distinct-line cap.
    if (current == 0 && state.items.length >= GetTicketState.kMaxLineItems) {
      return;
    }

    final int cap = state.capFor(tier);
    if (current >= cap) return;

    final Map<String, int> next = Map<String, int>.from(state.quantities)
      ..[e.tierId] = current + 1;
    emit(state.copyWith(quantities: next));
  }

  void _onDecremented(
    final GetTicketDecremented e,
    final Emitter<GetTicketState> emit,
  ) {
    final int current = state.quantities[e.tierId] ?? 0;
    if (current == 0) return;

    final Map<String, int> next = Map<String, int>.from(state.quantities);
    if (current == 1) {
      next.remove(e.tierId);
    } else {
      next[e.tierId] = current - 1;
    }
    emit(state.copyWith(quantities: next));
  }

  void _onCleared(
    final GetTicketCleared e,
    final Emitter<GetTicketState> emit,
  ) {
    emit(state.copyWith(quantities: const <String, int>{}));
  }

  TicketTier? _tier(String id) {
    for (final TicketTier t in state.tiers) {
      if (t.id == id) return t;
    }
    return null;
  }
}
