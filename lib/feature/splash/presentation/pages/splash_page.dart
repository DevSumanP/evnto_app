// ==============================================================================
// lib/feature/splash/presentation/pages/splash_page.dart
// Splash screen.
//
// Runs the startup checks via SplashBloc and routes to the right place once
// they finish. While checks are running, shows the logo and a small status
// indicator. On hard errors a retry button re-runs the bloc.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/splash_navigation_result.dart';
import '../blocs/splash_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => inject<SplashBloc>()..add(const SplashEvent.started()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: _onStateChanged,
        child: const _SplashView(),
      ),
    );
  }

  void _onStateChanged(BuildContext context, SplashState state) {
    if (state.status != SplashStatus.navigating) return;
    final next = state.nextRoute;
    if (next == null) return;

    switch (next) {
      case SplashNavigationResult.noInternet:
        context.router.replaceAll([NoInternetRoute()]);
        break;
      case SplashNavigationResult.maintenance:
        context.router.replaceAll([const UnderMaintenanceRoute()]);
        break;
      case SplashNavigationResult.onboard:
        context.router.replaceAll([const OnBoardRoute()]);
        break;
      case SplashNavigationResult.login:
        context.router.replaceAll([const LoginRoute()]);
        break;
      case SplashNavigationResult.chooseLocation:
        context.router.replaceAll([const ChooseLocationRoute()]);
        break;
      case SplashNavigationResult.home:
        context.router.replaceAll([const MainShellRoute()]);
        break;
    }
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,

        // Bottom navigation bar (Android)
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Spacer(flex: 3),
                  const _LogoBlock(),
                  const Spacer(flex: 3),
                  (state.status == SplashStatus.error)
                      ? Column(
                          children: [
                            _StatusBlock(state: state),
                            const SizedBox(height: 48),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  const _LogoBlock();

  @override
  Widget build(BuildContext context) {
    // Gentle fade and scale so the logo eases in as the splash mounts.
    return Center(
      child: Text(
        'Evnto.',
        style: AppTextStyles.h2Bold.copyWith(
          fontSize: 38,
          fontWeight: FontWeight.w900,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _StatusBlock extends StatelessWidget {
  const _StatusBlock({required this.state});

  final SplashState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == SplashStatus.error) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: AppColors.errorLight, size: 32),
            const SizedBox(height: 8),
            Text(
              'Something went wrong starting the app.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  context.read<SplashBloc>().add(const SplashEvent.started()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
                foregroundColor: AppColors.white,
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.bodySmallMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: 26,
      height: 26,
      child: CircularProgressIndicator(
        strokeWidth: 2.6,
        valueColor: AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }
}
