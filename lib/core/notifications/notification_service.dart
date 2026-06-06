import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/utils/logger.dart';

@lazySingleton
class NotificationService {
  NotificationService(this._messaging, this._local, this._apiClient);

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _local;
  final ApiClient _apiClient;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'tap_default',
    'Tap Notifications',
    description: 'Tap app push notifications',
    importance: Importance.high,
  );

  // Call once during app startup. Requests permission, sets up the
  // local notification plugin, and starts listening for foreground messages.
  Future<void> init() async {
    //1. Permission
    final settings = await _messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      AppLogger.instance.warning(
        'push permission denied',
        category: 'Notifications',
      );
      return;
    }

    // 2. Android channel + local plugin init
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    await _local.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onLocalTap,
    );

    // 3. Foreground listener - show local notif since FCM doesn't render in fg
    FirebaseMessaging.onMessage.listen(_showForeground);

    // 4. Tap-to-open handlers (cold start + warm).
    // For cold start we defer to the first frame so the router is mounted.
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _handleTap(initial));
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);

    // 5. Register token + refresh listener
    await _registerToken();
    _messaging.onTokenRefresh.listen((_) => _registerToken());

    AppLogger.instance.success(
      'Notification service ready',
      category: 'Notifications',
    );
  }

  Future<void> _showForeground(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _local.show(
      message.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> _registerToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) return;
      final platform = Platform.isAndroid
          ? 'android'
          : Platform.isIOS
          ? 'ios'
          : 'web';
      await _apiClient.post<dynamic>(
        ApiEndpoints.registerDevice,
        data: {'fcm_token': token, 'platform': platform},
      );
      AppLogger.instance.success(
        'Push token registered',
        category: 'Notifications',
      );
    } catch (e, st) {
      AppLogger.instance.error('Token register failed', e, st, 'Notifications');
    }
  }

  void _onLocalTap(NotificationResponse r) {
    if (r.payload == null) return;
    final data = jsonDecode(r.payload!) as Map<String, dynamic>;
    _routeFromData(data.map((k, v) => MapEntry(k, v.toString())));
  }

  void _handleTap(RemoteMessage m) =>
      _routeFromData(m.data.cast<String, String>());

  void _routeFromData(Map<String, String> data) {
    final router = inject<AppRouter>();
    final eventId = data['event_id'];
    final orderId = data['order_id'];
    if (orderId != null) {
      router.push(TicketsRoute()); // or order detail when route exists
    } else if (eventId != null) {
      router.push(EventDetailRoute(eventId: eventId));
    }
  }
}
