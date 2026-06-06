// ==============================================================================
// lib/core/router/app_router.dart
// auto_route configuration.
//
// Routes for the Tap Events app. After editing this file, regenerate the
// companion `app_router.gr.dart` by running:
//
//   dart run build_runner build --delete-conflicting-outputs
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/feature/auth/presentation/pages/login_page.dart';
import 'package:tap_app/feature/auth/presentation/pages/signup_page.dart';
import 'package:tap_app/feature/checkout/domain/entities/cart_item.dart';
import 'package:tap_app/feature/event-detail/presentation/pages/event_detail_page.dart';
import 'package:tap_app/feature/explore/presentation/pages/explore_page.dart';
import 'package:tap_app/feature/favorite/presentation/pages/favorite_page.dart';
import 'package:tap_app/feature/home/presentation/pages/home_page.dart';
import 'package:tap_app/feature/location/presentation/pages/choose_location_page.dart';
import 'package:tap_app/feature/onboard/presentation/pages/onboard_page.dart';
import 'package:tap_app/feature/profile/presentation/pages/profile_page.dart';
import 'package:tap_app/feature/shell/presentation/pages/main_shell_page.dart';
import 'package:tap_app/feature/splash/presentation/pages/splash_page.dart';
import 'package:tap_app/feature/tickets/presentation/pages/ticket_detail_page.dart';
import 'package:tap_app/feature/tickets/presentation/pages/ticket_qr_page.dart';
import 'package:tap_app/feature/tickets/presentation/pages/tickets_page.dart';
import 'package:tap_app/shared/widgets/common/no_internet_widget.dart';
import 'package:tap_app/shared/widgets/common/success_screen.dart';
import 'package:tap_app/feature/checkout/presentation/pages/get_ticket_page.dart';
import 'package:tap_app/feature/checkout/presentation/pages/order_complete_page.dart';
import 'package:tap_app/feature/checkout/presentation/pages/order_review_page.dart';
import 'package:tap_app/shared/widgets/common/under_maintenance.dart';

import '../../feature/checkout/data/models/checkout_initiate_model.dart';
import '../../feature/profile/domain/entities/user_profile.dart';
import '../../feature/profile/presentation/pages/edit_profile_page.dart';
import '../../feature/tickets/domain/entities/ticket_entity.dart';

part 'app_router.gr.dart';

/// Top-level router for the Tap Events app.
@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    // Splash is the entry route. It decides where to send the user next.
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),

    // Auth + onboarding flows.
    AutoRoute(page: OnBoardRoute.page, path: '/onboard'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signup'),

    // Post-signup location picker (shown once until a city is stored).
    AutoRoute(page: ChooseLocationRoute.page, path: '/choose-location'),

    // Signed-in home.
    AutoRoute(
      page: MainShellRoute.page,
      path: '/home',
      children: [
        AutoRoute(page: HomeTabRoute.page, path: 'home', initial: true),
        AutoRoute(page: ExploreRoute.page, path: 'explore'),
        AutoRoute(page: FavoriteRoute.page, path: 'favorite'),
        AutoRoute(page: TicketsRoute.page, path: 'tickets'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),

    // Event detail (reachable from any signed-in tab).
    AutoRoute(page: EventDetailRoute.page, path: '/event/:id'),

    // Ticket detail + QR. The ticket itself is passed as a route arg so we
    // don't re-fetch the list; the QR page lazily fetches a short-lived
    // token via TicketDetailBloc.
    AutoRoute(page: TicketDetailRoute.page, path: '/tickets/:id'),
    AutoRoute(page: TicketQrRoute.page, path: '/tickets/:id/qr'),

    // Checkout — Get a Ticket screen (cart).
    AutoRoute(page: GetTicketRoute.page, path: '/event/:id/buy'),

    // Checkout — Order Review screen. eventId comes from the path; the cart
    // and buyer arrive as constructor args (no order_id yet — it's minted by
    // Place Order on this screen).
    AutoRoute(page: OrderReviewRoute.page, path: '/event/:id/review'),

    // Checkout — terminal receipt screen. Reached after Khalti verify
    // succeeds. The route replaces Order Review so the back button doesn't
    // send the user back into a stale checkout.
    AutoRoute(page: OrderCompleteRoute.page, path: '/order/:id/complete'),

    // Profile Edit
    AutoRoute(page: EditProfileRoute.page, path: '/profile/edit'),

    // Failure / blocking states reachable from the splash.
    AutoRoute(page: NoInternetRoute.page, path: '/no-internet'),
    AutoRoute(page: UnderMaintenanceRoute.page, path: '/maintenance'),

    // Generic success screen used by feature flows.
    AutoRoute(page: SuccessRoute.page, path: '/success'),

    // Fallback.
    AutoRoute(page: NotFoundRoute.page, path: '/404'),
    RedirectRoute(path: '*', redirectTo: '/404'),
  ];
}

/// Default page shown for unknown paths.
@RoutePage(name: 'NotFoundRoute')
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Not found')),
    body: const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          '404 - Page not found',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
