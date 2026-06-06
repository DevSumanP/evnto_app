// ==============================================================================
// lib/core/base/base_bloc.dart
// Base class for all BLoCs. Adds standard logging and a helper to turn
// exceptions into Failure values.
// ==============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import '../errors/error_handler.dart';
import '../errors/failures.dart';
import '../utils/logger.dart';
import 'base_event.dart';
import 'base_state.dart';

/// Base class all app BLoCs should extend.
///
/// What it gives you:
///   - logs for every event, state change, error and close
///   - one call to turn any exception into a typed Failure
abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState>
    extends Bloc<E, S> {
  BaseBloc(super.initState);

  final AppLogger _logger = AppLogger.instance;
  final ErrorHandler _errorHandler = ErrorHandler.instance;

  /// Name shown in log lines.
  String get blocName => runtimeType.toString();

  /// Turn [error] into a [Failure] and log it.
  ///
  /// Use inside event handlers:
  /// ```dart
  /// try {
  ///   ...
  /// } on Object catch (e, s) {
  ///   emit(SomeState.error(handleError(e, s)));
  /// }
  /// ```
  Failure handleError(final Object error, [final StackTrace? stackTrace]) {
    _logger.error('[$blocName] Error', error, stackTrace, 'BLoC');
    return _errorHandler.handleException(error, stackTrace);
  }

  /// User-friendly message for [failure].
  String getErrorMessage(final Failure failure) =>
      _errorHandler.getUserMessage(failure);

  @override
  void onEvent(final E event) {
    super.onEvent(event);
    _logger.debug('[$blocName] event: ${event.runtimeType}', category: 'BLoC');
  }

  @override
  void onTransition(final Transition<E, S> transition) {
    super.onTransition(transition);
    _logger.debug(
      '[$blocName] ${transition.currentState.runtimeType} → '
      '${transition.nextState.runtimeType}',
      category: 'BLoC',
    );
  }

  @override
  void onError(final Object error, final StackTrace stackTrace) {
    super.onError(error, stackTrace);
    _logger.error('[$blocName] error', error, stackTrace, 'BLoC');
  }

  @override
  Future<void> close() {
    _logger.lifecycle('[$blocName] closed', category: 'BLoC');
    return super.close();
  }
}
