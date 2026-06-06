// ==============================================================================
// lib/core/di/core_injection.dart
// GetIt + Injectable bootstrap.
//
// The generated companion file `core_injection.config.dart` comes from
// `flutter pub run build_runner build`. If it has not been generated yet,
// the `getIt.init(...)` call below will fail at startup. That is on purpose:
// running with an empty DI container would only fail later, more confusingly.
// ==============================================================================

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core_injection.config.dart';

/// Process-wide service locator.
final GetIt getIt = GetIt.instance;

/// Resolve a registered dependency.
/// Use the same call style everywhere (`inject<MyService>()`) so it is easy
/// to grep for service consumers.
T inject<T extends Object>({final String? instanceName}) =>
    getIt<T>(instanceName: instanceName);

/// True if [T] is currently registered.
bool isRegistered<T extends Object>({
  final Object? instance,
  final String? instanceName,
}) => getIt.isRegistered<T>(instance: instance, instanceName: instanceName);

/// Configure the DI container for the given [environment]
/// (`development`, `staging`, `production`. See `Flavor`).
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({required final String environment}) async {
  await getIt.init(environment: environment);
}

/// Tear down the container. Tests only. Production code must not call this.
Future<void> resetDependencies() => getIt.reset();

/// Unregister a specific binding. Tests / dev only.
Future<void> unregister<T extends Object>({
  final Object? instance,
  final String? instanceName,
}) async => getIt.unregister<T>(instance: instance, instanceName: instanceName);
