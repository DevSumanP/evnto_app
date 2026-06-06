// ==============================================================================
// lib/feature/splash/domain/usecases/check_initial_status_use_case.dart
// The startup decision tree the splash runs once before navigating.
//
// Order matters:
//   1. Connectivity   -> NoInternet on offline
//   2. Backend health -> Maintenance on unreachable/down
//   3. Auth token     -> Home if token present, OnBoard otherwise
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/services/auth_session_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/splash_navigation_result.dart';
import 'check_app_status_use_case.dart';

@lazySingleton
class InitializeAppUseCase
    implements UseCase<SplashNavigationResult, NoParams> {
  InitializeAppUseCase(this._checkAppStatusUseCase, this._storage, this._session);

  final CheckAppStatusUseCase _checkAppStatusUseCase;
  final StorageService _storage;
  final AuthSessionService _session;

  @override
  Future<Either<Failure, SplashNavigationResult>> call(
    final NoParams params,
  ) async {
    // 1. Connectivity. Cheap local check before hitting the network.
    final bool online = await NetworkInfo.instance.isConnected;
    if (!online) {
      return const Right<Failure, SplashNavigationResult>(
        SplashNavigationResult.noInternet,
      );
    }

    // 2. Backend health.
    final Either<Failure, dynamic> healthResult =
        await _checkAppStatusUseCase(const NoParams());

    final SplashNavigationResult? maintenanceDecision = healthResult.fold(
      (final Failure failure) {
        // Connection failures during the health probe mean the backend is
        // not reachable. Treat that as maintenance for the user.
        if (failure is NoInternetFailure) {
          return SplashNavigationResult.noInternet;
        }
        return SplashNavigationResult.maintenance;
      },
      (final dynamic health) {
        // health.maintenance is set by the server when it wants the app to
        // hold off (planned downtime, force-update window, etc.).
        if (health is Object && _readMaintenance(health)) {
          return SplashNavigationResult.maintenance;
        }
        return null;
      },
    );
    if (maintenanceDecision != null) {
      return Right<Failure, SplashNavigationResult>(maintenanceDecision);
    }

    // 3. Auth. Decide using both the token and its stored expiry:
    //   - no token at all          -> onboard (unsigned-in)
    //   - token + not expired      -> home / chooseLocation
    //   - token + expired
    //       + refresh available    -> try refresh; on success go signed-in,
    //                                 on failure go to login
    //       + no refresh available -> login
    final String? token = _storage.getAuthToken();
    if (token == null || token.isEmpty) {
      return const Right<Failure, SplashNavigationResult>(
        SplashNavigationResult.onboard,
      );
    }

    if (_session.isAccessTokenExpired) {
      if (!_session.canRefresh) {
        await _session.markExpired();
        return const Right<Failure, SplashNavigationResult>(
          SplashNavigationResult.login,
        );
      }
      try {
        await _session.refresh();
      } on Object {
        // Service has already cleared local credentials and emitted
        // SessionExpired. Send the user to login.
        return const Right<Failure, SplashNavigationResult>(
          SplashNavigationResult.login,
        );
      }
    }

    // Signed in. If we have not yet captured a city, route through the
    // Choose Location screen once.
    if (!_storage.isUserLocationSet) {
      return const Right<Failure, SplashNavigationResult>(
        SplashNavigationResult.chooseLocation,
      );
    }
    return const Right<Failure, SplashNavigationResult>(
      SplashNavigationResult.home,
    );
  }

  bool _readMaintenance(final Object health) {
    try {
      return (health as dynamic).maintenance == true;
    } catch (_) {
      return false;
    }
  }
}
