// ==============================================================================
// lib/core/utils/debouncer.dart
// Debouncer and Throttler for rate-limiting callbacks.
// ==============================================================================

import 'dart:async';

/// Delays a callback until [delay] has passed since the last call.
///
/// Use for search-as-you-type fields: you want one request after the user
/// stops typing, not one per keystroke.
class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 500)});

  /// How long to wait after the last call to [run] before firing.
  final Duration delay;

  Timer? _timer;

  /// Schedule [action]. Cancels any action that is still pending.
  void run(final void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel the pending action, if any.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Whether an action is currently scheduled.
  bool get isActive => _timer?.isActive ?? false;

  /// Always call this from `State.dispose` or `Bloc.close`.
  void dispose() => cancel();
}

/// Lets a callback fire at most once per [delay] window.
///
/// The first call fires right away. Calls inside the window are dropped
/// until it ends.
class Throttler {
  Throttler({this.delay = const Duration(milliseconds: 500)});

  final Duration delay;

  /// Starts true so the first call to [run] actually fires.
  /// (The previous version started this as false, which dropped the first call.)
  bool _isReady = true;
  Timer? _timer;

  /// Run [action] if the window is open. Otherwise drop it.
  void run(final void Function() action) {
    if (!_isReady) return;
    action();
    _isReady = false;
    _timer = Timer(delay, () => _isReady = true);
  }

  /// Cancel the cooldown and reopen the window now.
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _isReady = true;
  }

  /// Always call this from `State.dispose` or `Bloc.close`.
  void dispose() => cancel();
}
