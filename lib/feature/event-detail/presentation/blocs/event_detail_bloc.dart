import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';
import 'package:tap_app/feature/event-detail/domain/usecases/get_event_detail_usecase.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_cubit.dart';

part 'event_detail_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
@freezed
class EventDetailEvent with _$EventDetailEvent implements BaseBlocEvent {
  const factory EventDetailEvent.started(String eventId) = EventDetailStarted;
  const factory EventDetailEvent.retried() = EventDetailRetried;
}

// ─── Status ──────────────────────────────────────────────────────────────────
enum EventDetailStatus { idle, loading, loaded, failure }

// ─── State ───────────────────────────────────────────────────────────────────
@freezed
abstract class EventDetailState
    with _$EventDetailState
    implements BaseBlocState {
  const factory EventDetailState({
    @Default('') String eventId,
    @Default(EventDetailStatus.idle) EventDetailStatus status,
    EventDetail? detail,
    String? error,
  }) = _EventDetailState;

  const EventDetailState._();

  bool get isLoading => status == EventDetailStatus.loading;
  bool get hasFailed => status == EventDetailStatus.failure;
  bool get hasLoaded => status == EventDetailStatus.loaded && detail != null;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────

@injectable
class EventDetailBloc extends BaseBloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc(this._getEventDetail, this._favorites)
      : super(const EventDetailState()) {
    on<EventDetailStarted>(_onStarted);
    on<EventDetailRetried>(_onRetried);
  }

  final GetEventDetailUsecase _getEventDetail;
  final FavoritesCubit _favorites;

  Future<void> _onStarted(
    final EventDetailStarted event,
    final Emitter<EventDetailState> emit,
  ) async {
    emit(state.copyWith(eventId: event.eventId));
    await _onLoad(emit, event.eventId);
  }

  Future<void> _onRetried(
    final EventDetailRetried event,
    final Emitter<EventDetailState> emit,
  ) async {
    final String id = state.eventId;
    if (id.isEmpty) {
      // Retry was fired before started — nothing to fetch. Ignore.
      return;
    }
    await _onLoad(emit, id);
  }

  Future<void> _onLoad(
    final Emitter<EventDetailState> emit,
    final String eventId,
  ) async {
    emit(state.copyWith(status: EventDetailStatus.loading, error: null));

    final result = await _getEventDetail(
      GetEventDetailParams(eventId: eventId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EventDetailStatus.failure,
          error: getErrorMessage(failure),
        ),
      ),
      (detail) {
        _favorites.hydrateOne(detail.id, detail.isFavorited);
        emit(
          state.copyWith(
            status: EventDetailStatus.loaded,
            detail: detail,
            error: null,
          ),
        );
      },
    );
  }
}
