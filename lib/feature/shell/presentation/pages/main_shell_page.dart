import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

@RoutePage()
class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,

        // Bottom navigation bar (Android)
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: AutoTabsScaffold(
        routes: const [
          HomeTabRoute(),
          ExploreRoute(),
          FavoriteRoute(),
          TicketsRoute(),
          ProfileRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.primary500,
            unselectedItemColor: AppColors.text300,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageConstants.homeNavInactive,
                  color: AppColors.text300,
                  height: 28,
                  width: 28,
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstants.homeNavActive,
                  height: 28,
                  width: 28,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageConstants.exploreNavInactive,
                  color: AppColors.text300,
                  height: 28,
                  width: 28,
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstants.exploreNavActive,
                  height: 28,
                  width: 28,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageConstants.favoriteNavInactive,
                  color: AppColors.text300,
                  height: 28,
                  width: 28,
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstants.favoriteNavActive,
                  height: 28,
                  width: 28,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageConstants.ticketNavInactive,
                  color: AppColors.text300,
                  height: 28,
                  width: 28,
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstants.ticketNavActive,
                  height: 28,
                  width: 28,
                ),
                label: 'Tickets',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ImageConstants.user,
                  color: AppColors.text300,
                  height: 28,
                  width: 28,
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstants.user,
                  color: AppColors.primary,
                  height: 28,
                  width: 28,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
