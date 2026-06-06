// ==============================================================================
// lib/feature/auth/presentation/widgets/session_listener.dart
// Listens to AuthSessionService.events and routes the user back to login
// whenever the session ends (expired refresh, or explicit sign-out).
//
// Sits inside MaterialApp.router's builder so it has the router context but
// stays above the navigator. Mounted once for the life of the app.
// ==============================================================================

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/auth_session_service.dart';
import '../../../favorite/presentation/blocs/favorites_cubit.dart';

class SessionListener extends StatefulWidget {
  const SessionListener({required this.child, super.key});

  final Widget child;

  @override
  State<SessionListener> createState() => _SessionListenerState();
}

class _SessionListenerState extends State<SessionListener> {
  late final StreamSubscription<SessionEvent> _subscription;
  late final StreamSubscription<FavoritesError> _favSub;

  @override
  void initState() {
    super.initState();
    _subscription = inject<AuthSessionService>().events.listen(_onEvent);
    _favSub = inject<FavoritesCubit>().errors.listen(_onFavError);
  }

  void _onFavError(final FavoritesError e) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.maybeOf(context);
    final String msg = e.failure is UnauthorizedFailure
        ? 'Sign in to save events.'
        : 'Could not update favorite. Try again.';
    messenger?.showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onEvent(final SessionEvent event) {
    if (!mounted) return;
    switch (event) {
      case SessionExpired():
        _goToLogin(
          snackBarMessage: 'Your session has expired. Please sign in again.',
        );
      case SessionSignedOut():
        _goToLogin();
    }
  }

  void _goToLogin({final String? snackBarMessage}) {
    // Replace the whole stack so the user cannot back-button into the
    // previous signed-in screen.
    context.router.replaceAll(<PageRouteInfo>[const LoginRoute()]);

    if (snackBarMessage != null) {
      // Schedule after the route swap so the snackbar attaches to the new
      // ScaffoldMessenger, not the one we just torn down.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger?.showSnackBar(SnackBar(content: Text(snackBarMessage)));
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _favSub.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => widget.child;
}
