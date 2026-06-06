// ==============================================================================
// lib/app.dart
// Root widget. Sets up theme, routing, and global system UI overlays.
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

import 'core/config/app_config.dart';
import 'core/di/core_injection.dart';
import 'core/router/app_router.dart';
import 'core/router/route_observer.dart';
import 'feature/auth/presentation/widgets/session_listener.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;
  late final List<NavigatorObserver> _observers;

  static const double _maxTextScale = 1.3;

  @override
  void initState() {
    super.initState();
    _appRouter = inject<AppRouter>();
    _observers = <NavigatorObserver>[
      AppRouteObserver(),
      AnalyticsRouteObserver(),
      PosthogObserver(),
    ];
  }

  @override
  Widget build(final BuildContext context) => PostHogWidget(
    child: MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.instance.showDebugBanner,
      themeMode: ThemeMode.light,
      routerConfig: _appRouter.config(navigatorObservers: () => _observers),
      builder: (final BuildContext context, final Widget? child) {
        final MediaQueryData media = MediaQuery.of(context);
        final TextScaler clamped = media.textScaler.clamp(
          maxScaleFactor: _maxTextScale,
        );
        return MediaQuery(
          data: media.copyWith(textScaler: clamped),
          child: SessionListener(child: child ?? const SizedBox.shrink()),
        );
      },
    ),
  );
}
