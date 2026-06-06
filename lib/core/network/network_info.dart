// ==============================================================================
// lib/core/network/network_info.dart
// Network connectivity info.
//
// Combines two checks:
//   - which interface is active (Wi-Fi, mobile, etc.)
//   - whether that interface can actually reach the internet
//
// You need both, because a device can be on Wi-Fi without real internet
// access (captive portals, broken VPNs, etc.).
// ==============================================================================

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// The kind of network interface that is currently active.
enum NetworkConnectionType { wifi, mobile, ethernet, vpn, other, none }

/// Tells you whether the device is online and what kind of connection it has.
class NetworkInfo {
  NetworkInfo._internal();

  /// Shared singleton.
  static final NetworkInfo instance = NetworkInfo._internal();

  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetConnection = InternetConnection();

  /// Cache the last reachability result for a few seconds. Without this,
  /// a burst of API calls each pays for an extra HTTP probe.
  static const Duration _reachabilityCacheTtl = Duration(seconds: 3);
  bool? _cachedReachable;
  DateTime? _cachedReachableAt;

  /// True when the device has a working internet connection.
  ///
  /// Checks both:
  ///   - the active interface (Wi-Fi, mobile, etc.)
  ///   - real reachability (the interface actually reaches the internet)
  Future<bool> get isConnected async {
    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    if (_isOffline(results)) {
      _cachedReachable = false;
      _cachedReachableAt = DateTime.now();
      return false;
    }

    final DateTime? cachedAt = _cachedReachableAt;
    if (_cachedReachable != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _reachabilityCacheTtl) {
      return _cachedReachable!;
    }

    final bool reachable = await _internetConnection.hasInternetAccess;
    _cachedReachable = reachable;
    _cachedReachableAt = DateTime.now();
    return reachable;
  }

  /// Raw connectivity results (Wi-Fi, mobile, none, ...).
  Future<List<ConnectivityResult>> get connectivityResult =>
      _connectivity.checkConnectivity();

  /// The kind of active connection, or `none` when offline.
  Future<NetworkConnectionType> get connectionType async {
    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.wifi)) {
      return NetworkConnectionType.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return NetworkConnectionType.mobile;
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return NetworkConnectionType.ethernet;
    }
    if (results.contains(ConnectivityResult.vpn)) {
      return NetworkConnectionType.vpn;
    }
    if (results.contains(ConnectivityResult.bluetooth) ||
        results.contains(ConnectivityResult.other)) {
      return NetworkConnectionType.other;
    }
    return NetworkConnectionType.none;
  }

  /// Emits true or false whenever internet reachability changes.
  /// The cache is updated so the next [isConnected] call returns the new
  /// value right away.
  Stream<bool> get onConnectivityChanged =>
      _internetConnection.onStatusChange.map((final InternetStatus status) {
        final bool reachable = status == InternetStatus.connected;
        _cachedReachable = reachable;
        _cachedReachableAt = DateTime.now();
        return reachable;
      });

  /// Emits the new connectivity results whenever the active interface changes.
  Stream<List<ConnectivityResult>> get onConnectivityResultChanged =>
      _connectivity.onConnectivityChanged;

  bool _isOffline(final List<ConnectivityResult> results) =>
      results.isEmpty ||
      results.every(
        (final ConnectivityResult r) => r == ConnectivityResult.none,
      );
}
