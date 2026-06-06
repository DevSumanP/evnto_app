// ==============================================================================
// lib/core/di/modules/service_module.dart
// Service module for dependency injection
// ==============================================================================

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
