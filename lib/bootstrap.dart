// ==============================================================================
// lib/bootstrap.dart
// Bootstrap entry point. Runs every step the app needs before runApp().
//
// Each step is wrapped in its own logger group so the console shows a clean
// header and footer around the step's own log lines. AppLogger silences
// itself in release builds, so this only prints in dev.
// ==============================================================================

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/config/flavor.dart';
import 'core/di/core_injection.dart';
import 'core/errors/error_handler.dart';
import 'core/network/dio_client.dart';
import 'core/notifications/background_handler.dart';
import 'core/notifications/notification_service.dart';
import 'core/services/analytics/analytics_service.dart';
import 'core/services/error_reporting_service.dart';
import 'core/theme/app_colors.dart';
import 'core/utils/logger.dart';

/// Bootstrap the application. Runs every init step, then runApp().
Future<void> bootstrap({
  required final Widget Function() builder,
  required final Flavor flavor,
}) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Logger first so every step can log.
      AppLogger.instance.initialize();

      AppLogger.instance.section('🚀  APPLICATION BOOTSTRAP');
      AppLogger.instance.tree('Environment', <String, Object?>{
        'Flavor': flavor.displayName,
        'Started at': DateTime.now().toIso8601String(),
        'Entry point': 'main_${flavor.name}.dart',
      });
      AppLogger.instance.divider();

      // Load .env first. Every step after this may read from it.
      await AppConfig.initialize(flavor);

      // Status bar, navigation bar, and edge-to-edge mode.
      await _configureSystemUI();

      // Register all services with GetIt + Injectable.
      await _initializeDependencyInjection(flavor.name);

      // Build the Dio HTTP client and attach interceptors.
      _initializeApiClient();

      // Firebase setup. Reads native config files.
      await _initializeFirebase();

      // Push notification service. Needs DI + Firebase ready.
      await _initializeNotifications();

      // Connect PostHog analytics. No-op if the API key is missing.
      await _initializeAnalytics();

      // Hook FlutterError.onError and PlatformDispatcher.onError.
      _initializeErrorHandling();

      // Install the global BLoC observer for dev logging.
      _setupBlocObserver();

      // Force portrait orientation.
      await _lockOrientation();

      // Print the final "bootstrap done" banner.
      _showCompletionSummary();

      runApp(builder());
    },
    (final Object error, final StackTrace stack) {
      AppLogger.instance.error(
        'Uncaught error in application',
        error,
        stack,
        'Bootstrap',
      );
      ErrorHandler.instance.handleException(error, stack);
    },
  );
}

/// Configure system UI overlays and styles.
Future<void> _configureSystemUI() async {
  await AppLogger.instance.groupAsync('📱  System UI configuration', () async {
    AppLogger.instance.info(
      'Setting preferred orientations...',
      category: 'SystemUI',
    );
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    AppLogger.instance.info(
      'Configuring overlay style...',
      category: 'SystemUI',
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primary500,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    AppLogger.instance.info(
      'Enabling edge-to-edge mode...',
      category: 'SystemUI',
    );
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    AppLogger.instance.success('System UI configured', category: 'SystemUI');
  });
}

/// Initialize dependency injection.
Future<void> _initializeDependencyInjection(final String environment) async {
  await AppLogger.instance.groupAsync('🔌  Dependency injection', () async {
    AppLogger.instance.info('Configuring dependencies...', category: 'DI');

    final Stopwatch stopwatch = Stopwatch()..start();
    await configureDependencies(environment: environment);
    stopwatch.stop();

    AppLogger.instance.keyValue(
      'Setup time',
      '${stopwatch.elapsedMilliseconds}ms',
    );
    AppLogger.instance.success('Dependencies configured', category: 'DI');
  });
}

/// Initialize the API client.
void _initializeApiClient() {
  AppLogger.instance.group('🔗  API client initialization', () {
    AppLogger.instance.info('Initializing Dio client...', category: 'Network');
    DioClient.instance.initialize();
    AppLogger.instance.success('API client initialized', category: 'Network');
  });
}

/// Initialize Firebase services.
/// Reads platform config from google-services.json (Android) and
/// GoogleService-Info.plist (iOS). Must run before any FCM call.
Future<void> _initializeFirebase() async {
  await AppLogger.instance.groupAsync('🟧  Firebase initialization', () async {
    AppLogger.instance.info('Initializing Firebase...', category: 'Firebase');
    await Firebase.initializeApp();
    // Background handler must be registered before runApp so the OS can
    // wake an isolate when a push arrives while the app is killed.
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
    AppLogger.instance.success('Firebase initialized', category: 'Firebase');
  });
}

/// Initialize the push notification service. Permission, channel, listeners,
/// and FCM token registration with the backend.
Future<void> _initializeNotifications() async {
  await AppLogger.instance.groupAsync('🔔  Notifications', () async {
    AppLogger.instance.info(
      'Starting notification service...',
      category: 'Notifications',
    );
    await inject<NotificationService>().init();
  });
}

/// Initialize analytics.
Future<void> _initializeAnalytics() async {
  await AppLogger.instance.groupAsync('📊  Analytics initialization', () async {
    AppLogger.instance.info(
      'Initializing PostHog analytics...',
      category: 'Analytics',
    );
    await inject<AnalyticsService>().initialize();
    AppLogger.instance.success('Analytics initialized', category: 'Analytics');
  });
}

/// Initialize global error handling.
void _initializeErrorHandling() {
  AppLogger.instance.group('🛡️  Error handling', () {
    AppLogger.instance.info(
      'Configuring error handlers...',
      category: 'ErrorHandler',
    );
    // ErrorHandler.initialize() owns FlutterError.onError and
    // PlatformDispatcher.onError. The runZonedGuarded in bootstrap() is
    // the outer safety net for anything those miss.
    ErrorHandler.instance.initialize(
      errorReportingService: ErrorReportingService.instance,
    );
    AppLogger.instance.success(
      'Error handlers configured',
      category: 'ErrorHandler',
    );
  });
}

/// Register the BLoC observer.
void _setupBlocObserver() {
  AppLogger.instance.group('🧩  BLoC observer', () {
    AppLogger.instance.info('Registering observer...', category: 'BLoC');
    Bloc.observer = AppBlocObserver();
    AppLogger.instance.success('BLoC observer registered', category: 'BLoC');
  });
}

/// Lock device orientation to portrait.
Future<void> _lockOrientation() async {
  await AppLogger.instance.groupAsync('🔒  Orientation lock', () async {
    AppLogger.instance.info(
      'Locking orientation to portrait',
      category: 'SystemUI',
    );
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AppLogger.instance.success('Orientation locked', category: 'SystemUI');
  });
}

/// Final completion banner.
void _showCompletionSummary() {
  AppLogger.instance.section('✨  BOOTSTRAP COMPLETE');
  AppLogger.instance.success(
    'Application is ready to run',
    category: 'Bootstrap',
  );
  AppLogger.instance.divider();
}

/// BLoC observer used for development logging.
class AppBlocObserver extends BlocObserver {
  final AppLogger _logger = AppLogger.instance;

  @override
  void onCreate(final BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _logger.lifecycle('🟢 ${bloc.runtimeType} created', category: 'BLoC');
  }

  @override
  void onChange(final BlocBase<dynamic> bloc, final Change<dynamic> change) {
    super.onChange(bloc, change);
    _logger.debug(
      '${bloc.runtimeType}\n'
      '  ├─ From: ${change.currentState.runtimeType}\n'
      '  └─ To:   ${change.nextState.runtimeType}',
      category: 'BLoC',
    );
  }

  @override
  void onError(
    final BlocBase<dynamic> bloc,
    final Object error,
    final StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    _logger.error(
      'BLoC error in ${bloc.runtimeType}',
      error,
      stackTrace,
      'BLoC',
    );
  }

  @override
  void onClose(final BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _logger.lifecycle('🔴 ${bloc.runtimeType} closed', category: 'BLoC');
  }
}
