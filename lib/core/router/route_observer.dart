// ==============================================================================
// lib/core/router/route_observer.dart
// Navigation observers for logging and analytics screen tracking.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../di/core_injection.dart';
import '../services/analytics/analytics_service.dart';
import '../utils/logger.dart';

/// Logs every navigation event through [AppLogger].
class AppRouteObserver extends AutoRouteObserver {
  final AppLogger _logger = AppLogger.instance;

  @override
  void didPush(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    _logger.info(
      '${_name(previousRoute)} → ${_name(route)}',
      category: 'Nav',
    );
  }

  @override
  void didPop(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    _logger.info(
      '${_name(route)} ← ${_name(previousRoute)}',
      category: 'Nav',
    );
  }

  @override
  void didReplace({
    final Route<dynamic>? newRoute,
    final Route<dynamic>? oldRoute,
  }) {
    _logger.info(
      '${_name(oldRoute)} → ${_name(newRoute)} (replace)',
      category: 'Nav',
    );
  }

  @override
  void didRemove(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    _logger.info('${_name(route)} removed', category: 'Nav');
  }

  String _name(final Route<dynamic>? route) =>
      route?.settings.name ?? '<unnamed>';
}

/// Sends screen views to the analytics sink.
///
/// Resolves [AnalyticsService] on first use, not at field-init time. This
/// way the observer can be created before the DI container is fully ready.
class AnalyticsRouteObserver extends AutoRouterObserver {
  AnalyticsService? _analytics;

  AnalyticsService? _resolve() {
    final AnalyticsService? cached = _analytics;
    if (cached != null) return cached;
    if (!isRegistered<AnalyticsService>()) return null;
    return _analytics = inject<AnalyticsService>();
  }

  @override
  void didPush(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    _trackScreenView(route);
  }

  @override
  void didReplace({
    final Route<dynamic>? newRoute,
    final Route<dynamic>? oldRoute,
  }) {
    if (newRoute != null) _trackScreenView(newRoute);
  }

  void _trackScreenView(final Route<dynamic> route) {
    final String? name = route.settings.name;
    if (name == null || name.isEmpty) return;
    _resolve()?.logScreenView(name);
  }
}
