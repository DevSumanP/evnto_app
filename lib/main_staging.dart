// ==============================================================================
// lib/main_staging.dart
// Staging entry point
// ==============================================================================

import 'package:tap_app/app.dart';
import 'package:tap_app/bootstrap.dart';
import 'package:tap_app/core/config/flavor.dart';

Future<void> main() async {
  await bootstrap(builder: () => const MyApp(), flavor: Flavor.staging);
}
