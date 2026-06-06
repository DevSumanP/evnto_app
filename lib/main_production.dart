// ==============================================================================
// lib/main_production.dart
// Production entry point
// ==============================================================================

import 'app.dart';
import 'bootstrap.dart';
import 'core/config/flavor.dart';

Future<void> main() async {
  await bootstrap(builder: () => const MyApp(), flavor: Flavor.production);
}
