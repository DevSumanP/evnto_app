import 'package:firebase_messaging/firebase_messaging.dart';

// Top-level function called by the OS when a push arrives and the app
// is not in the foreground. Must stay outside any class.
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  // The OS already shows the system tray notification.
  // Hook in here later if we need to update local state from a data-only push.
}
