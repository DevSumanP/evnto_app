import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/usecase.dart';
import '../../domain/entities/splash_navigation_result.dart';
import '../../domain/usecases/check_initial_status_use_case.dart';

part 'splash_bloc.freezed.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.started() = _Started;
}

enum SplashStatus { initial, loading, navigating, error }

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.initial) SplashStatus status,
    SplashNavigationResult? nextRoute,
  }) = _SplashState;
}

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final InitializeAppUseCase _initializeAppUseCase;

  SplashBloc(this._initializeAppUseCase) : super(const SplashState()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_Started event, Emitter<SplashState> emit) async {
    emit(state.copyWith(status: SplashStatus.loading));

    // Minimum 2 seconds display
    final stopwatch = Stopwatch()..start();

    final result = await _initializeAppUseCase(NoParams());

    final elapsed = stopwatch.elapsedMilliseconds;
    if (elapsed < 2000) {
      await Future.delayed(Duration(milliseconds: 2000 - elapsed));
    }

    result.fold(
      (failure) => emit(state.copyWith(status: SplashStatus.error)),
      (nextRoute) => emit(
        state.copyWith(status: SplashStatus.navigating, nextRoute: nextRoute),
      ),
    );
  }
}
