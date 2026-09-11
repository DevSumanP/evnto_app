// ==============================================================================
// lib/feature/home/presentation/pages/home_page.dart
// Home (Discover) tab. Three sections wired to HomeBloc:
//
//   1. Upcoming Events    — horizontal scroll of _UpcomingCard
//                           (image-left layout with date badge + Join button)
//   2. Popular Now        — horizontal scroll of _PopularCard
//                           (image-top stacked layout with date/price-chip)
//   3. Suggestion for you — vertical list, reuses _UpcomingCard.
//                           Hidden when no city is stored.
//
// Pull-to-refresh reloads all three sections in parallel. Each section has
// its own loading / empty / failure UI so one bad request does not blank the
// rest of the screen. The search field filters loaded events client-side.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/feature/home/presentation/widgets/sdui/home_search_bar.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/di/core_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/home_layout.dart';
import '../blocs/home_bloc.dart';
import '../blocs/home_layout_bloc.dart';
import '../widgets/cards/event_cards.dart';
import '../widgets/sdui/section_registry.dart';

@RoutePage(name: 'HomeTabRoute')
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    // Flag off → legacy fixed Home, untouched.
    if (!AppConfig.sduiHomeEnabled) return const _LegacyHome();

    // Flag on → resolve a server-driven layout. The legacy Home stays as the
    // fallback when the layout fails or is an unsupported schema version.
    return BlocProvider<HomeLayoutBloc>(
      create: (_) =>
          inject<HomeLayoutBloc>()..add(const HomeLayoutEvent.started()),
      child: const _SduiOrLegacyHome(),
    );
  }
}

/// The legacy fixed Home, self-contained with its own HomeBloc. Used both when
/// SDUI is disabled and as the fallback when an SDUI layout can't be rendered.
class _LegacyHome extends StatelessWidget {
  const _LegacyHome();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => inject<HomeBloc>()..add(const HomeEvent.started()),
      child: const _HomeView(),
    );
  }
}

/// Chooses between the SDUI layout and the legacy fallback based on the
/// HomeLayoutBloc state.
class _SduiOrLegacyHome extends StatelessWidget {
  const _SduiOrLegacyHome();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<HomeLayoutBloc, HomeLayoutState>(
      builder: (final BuildContext context, final HomeLayoutState state) {
        if (state.isFailure) return const _LegacyHome();
        if (state.hasLayout) return _SduiHomeView(layout: state.layout!);
        // idle / loading
        return const Scaffold(
          backgroundColor: AppColors.text10,
          body: Center(
            child: CircularProgressIndicator(color: AppColors.primary500),
          ),
        );
      },
    );
  }
}

/// Renders a server-driven layout: the shared location header on top, then each
/// section walked through the component registry.
class _SduiHomeView extends StatelessWidget {
  const _SduiHomeView({required this.layout});

  final HomeLayout layout;

  @override
  Widget build(final BuildContext context) {
    final StorageService storage = inject<StorageService>();

    return Scaffold(
      backgroundColor: AppColors.text10,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary500,
          onRefresh: () async => context.read<HomeLayoutBloc>().add(
            const HomeLayoutEvent.refreshed(),
          ),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: _TitleBar(
                  city: storage.getUserCity(),
                  country: storage.getUserCountry(),
                ),
              ),
              for (final section in layout.sections)
                SliverToBoxAdapter(child: buildSection(context, section)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(const HomeEvent.refreshed());
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.text10,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (final BuildContext context, final HomeState state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.primary500,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _TitleBar(city: state.city, country: state.country),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: _SearchField(
                        controller: _searchController,
                        onChanged: (final String value) => context
                            .read<HomeBloc>()
                            .add(HomeEvent.queryChanged(value)),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: _SectionHeader(title: 'Upcoming Events'),
                  ),
                  SliverToBoxAdapter(
                    child: _UpcomingHorizontalList(
                      status: state.upcomingStatus,
                      items: state.filteredUpcoming,
                      error: state.upcomingError,
                      onRetry: () => context.read<HomeBloc>().add(
                        const HomeEvent.upcomingRetried(),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: _SectionHeader(title: 'Popular Now'),
                  ),
                  SliverToBoxAdapter(
                    child: _PopularHorizontalList(
                      status: state.popularStatus,
                      items: state.filteredPopular,
                      error: state.popularError,
                      onRetry: () => context.read<HomeBloc>().add(
                        const HomeEvent.popularRetried(),
                      ),
                    ),
                  ),
                  if (state.hasCity) ...<Widget>[
                    const SliverToBoxAdapter(
                      child: _SectionHeader(title: 'Suggestion for you'),
                    ),
                    _SuggestionsSliver(
                      status: state.suggestedStatus,
                      items: state.filteredSuggested,
                      error: state.suggestedError,
                      onRetry: () => context.read<HomeBloc>().add(
                        const HomeEvent.suggestionsRetried(),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Title bar ───────────────────────────────────────────────────────────────

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.city, required this.country});

  final String? city;
  final String? country;

  String get _displayLocation {
    final String c = city ?? '';
    final String co = country ?? '';
    if (c.isEmpty) return 'Pick a city';
    if (co.isEmpty) return c;
    return '$c, $co';
  }

  @override
  Widget build(final BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => context.router.push(const ChooseLocationRoute()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Find events near',
                          style: AppTextStyles.captionRegular.copyWith(
                            color: AppColors.text300,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                _displayLocation,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.h4Bold.copyWith(
                                  color: AppColors.text500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.text500,
                              size: 22,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.primary50,
                    ),
                    child: Center(
                      child: SvgPicture.asset(ImageConstants.notification02),
                    ),
                  ),

                  // Notification dot
                  Positioned(
                    top: 13,
                    right: 13,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SearchHeader(
            controller: _searchController,
            onChanged: (val) {},
            onSubmitted: (val) {},
            onClear: () {},
          ),
        ],
      ),
    );
  }
}

// ─── Search field ────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(final BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTextStyles.bodySmallRegular.copyWith(
        fontSize: 15,
        color: AppColors.text500,
      ),
      decoration: InputDecoration(
        hintText: 'Search all events...',
        hintStyle: AppTextStyles.bodySmallMedium.copyWith(
          fontSize: 15,
          color: AppColors.text300,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            bottom: 16.0,
            right: 8.0,
          ),
          child: SvgPicture.asset(ImageConstants.search, height: 22, width: 22),
        ),
        filled: true,
        fillColor: AppColors.primary50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary500, width: 1.5),
        ),
      ),
    );
  }
}

// ─── Section header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'See All',
              style: AppTextStyles.bodySmallBold.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Upcoming Events — horizontal list ───────────────────────────────────────

class _UpcomingHorizontalList extends StatelessWidget {
  const _UpcomingHorizontalList({
    required this.status,
    required this.items,
    required this.onRetry,
    this.error,
  });

  final SectionStatus status;
  final List<Event> items;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    const double height = 260;

    if (status == SectionStatus.idle || status == SectionStatus.loading) {
      return SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, __) => const _UpcomingCardSkeleton(),
        ),
      );
    }

    if (status == SectionStatus.failure) {
      return SizedBox(
        height: height,
        child: _SectionError(message: error, onRetry: onRetry),
      );
    }

    if (items.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No events here yet.',
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: AppColors.text300,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (final BuildContext context, final int index) =>
            SizedBox(width: 200, child: UpcomingCard(event: items[index])),
      ),
    );
  }
}

// ─── Popular Now — horizontal list ───────────────────────────────────────────

class _PopularHorizontalList extends StatelessWidget {
  const _PopularHorizontalList({
    required this.status,
    required this.items,
    required this.onRetry,
    this.error,
  });

  final SectionStatus status;
  final List<Event> items;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    const double height = 260;

    if (status == SectionStatus.idle || status == SectionStatus.loading) {
      return SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, __) => const _PopularCardSkeleton(),
        ),
      );
    }

    if (status == SectionStatus.failure) {
      return SizedBox(
        height: height,
        child: _SectionError(message: error, onRetry: onRetry),
      );
    }

    if (items.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No events here yet.',
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: AppColors.text300,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (final BuildContext context, final int index) =>
            SizedBox(width: 160, child: PopularCard(event: items[index])),
      ),
    );
  }
}

// ─── Suggestion for you — vertical sliver (reuses _UpcomingCard) ─────────────

class _SuggestionsSliver extends StatelessWidget {
  const _SuggestionsSliver({
    required this.status,
    required this.items,
    required this.onRetry,
    this.error,
  });

  final SectionStatus status;
  final List<Event> items;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    if (status == SectionStatus.idle || status == SectionStatus.loading) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList.separated(
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, __) => const _UpcomingCardSkeleton(),
        ),
      );
    }

    if (status == SectionStatus.failure) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 120,
          child: _SectionError(message: error, onRetry: onRetry),
        ),
      );
    }

    if (items.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'No suggestions for your city yet.',
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (final BuildContext context, final int index) =>
            SuggestionCard(event: items[index]),
      ),
    );
  }
}

class _SectionError extends StatelessWidget {
  const _SectionError({required this.onRetry, this.message});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message ?? 'Could not load this section.',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.primary500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingCardSkeleton extends StatelessWidget {
  const _UpcomingCardSkeleton();

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 320,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _PopularCardSkeleton extends StatelessWidget {
  const _PopularCardSkeleton();

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
