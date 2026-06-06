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
import 'package:intl/intl.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/utils/context_extension.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/event_entity.dart';
import '../blocs/home_bloc.dart';

const Color _kAccentOrange = Color(0xFFFF8551);
const Color _kAccentOrangeSoft = Color(0xFFFFE5DA);

/// Returns the best location string we can show for [event].
/// Preference: City, Country > Venue name > '—'.
String _locationLabel(final Event event) {
  final String city = (event.venueCity ?? '').trim();
  final String country = (event.venueCountry ?? '').trim();
  if (city.isNotEmpty && country.isNotEmpty) return '$city, $country';
  if (city.isNotEmpty) return city;
  final String name = (event.venueName ?? '').trim();
  if (name.isNotEmpty) return name;
  return '—';
}

/// 'FREE' when every tier is 0 paisa, 'From Rs <amount>' when we know the
/// minimum price, '—' when the event has no tiers yet.
String _priceLabel(final Event event) {
  if (event.isFree) return 'FREE';
  final int? minPaisa = event.minPricePaisa;
  if (minPaisa == null) return '—';
  // Paisa → rupees. Cards stay compact; drop the decimals.
  final int rupees = (minPaisa / 100).round();
  return 'Rs $rupees';
}

@RoutePage(name: 'HomeTabRoute')
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => inject<HomeBloc>()..add(const HomeEvent.started()),
      child: const _HomeView(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
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
                    color: _kAccentOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
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
            onPressed:  () {},
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
    const double height = 120;

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
        itemBuilder: (final BuildContext context, final int index) => SizedBox(
          width: context.screenWidth - 40,
          child: _UpcomingCard(event: items[index]),
        ),
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
    const double height = 240;

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
            SizedBox(width: 240, child: _PopularCard(event: items[index])),
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
            _SuggestionCard(event: items[index]),
      ),
    );
  }
}

// ─── Upcoming card (image-left, used in Upcoming and Suggestions) ────────────

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.event});

  final Event event;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.router.push(EventDetailRoute(eventId: event.id)),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                width: 96,
                height: 96,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _CoverImage(url: event.heroImageUrl),
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: _DateBadge(date: event.startsAt, compact: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.text500,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  ImageConstants.locationFilled,
                                  height: 14,
                                  width: 14,
                                  color: AppColors.text300,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    _locationLabel(event),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyRegular.copyWith(
                                      fontSize: 14,
                                      color: AppColors.text300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _JoinButton(
                            label: event.isFree ? 'Free' : 'Join',
                            onPressed: () => context.router.push(
                              EventDetailRoute(eventId: event.id),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Suggestion card (image-left, used in Suggestion for you) ───────────────
//
// Mirrors _UpcomingCard's layout but swaps the "Join" call-to-action for a
// price-based action: "Free" when every tier is 0 paisa, the actual price
// otherwise, or "—" when we have no price info yet.

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.event});

  final Event event;

  static const double _height = 110;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: _height,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.router.push(EventDetailRoute(eventId: event.id)),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _CoverImage(url: event.heroImageUrl),
                      ),
                      Positioned(
                        top: 6,
                        left: 6,
                        child: _DateBadge(date: event.startsAt, compact: true),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.text500,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    ImageConstants.locationFilled,
                                    height: 14,
                                    width: 14,
                                    color: AppColors.text300,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      _locationLabel(event),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyRegular.copyWith(
                                        fontSize: 14,
                                        color: AppColors.text300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            _AccentChip(label: _priceLabel(event)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Popular card (image-top, used in Popular Now) ───────────────────────────

class _PopularCard extends StatelessWidget {
  const _PopularCard({required this.event});

  final Event event;

  @override
  Widget build(final BuildContext context) {
    final String dateLine =
        '${DateFormat('MMM d, y').format(event.startsAt)}  ·  ${DateFormat('h:mm a').format(event.startsAt)}';

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.router.push(EventDetailRoute(eventId: event.id)),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 140,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _CoverImage(url: event.heroImageUrl),
                    ),
                    if (event.isFeatured)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: _AccentChip(label: 'Featured'),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      dateLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.text500,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.text300,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _locationLabel(event),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyRegular.copyWith(
                              fontSize: 14,
                              color: AppColors.text300,
                            ),
                          ),
                        ),
                        _AccentChip(label: _priceLabel(event)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Reusable sub-widgets ────────────────────────────────────────────────────

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.url});

  final String? url;

  @override
  Widget build(final BuildContext context) {
    final String? src = url;
    if (src == null || src.isEmpty) {
      return const ColoredBox(color: AppColors.grey200);
    }
    return AppNetworkImage(
      src,
      fit: BoxFit.cover,
      placeholder: const ColoredBox(color: AppColors.grey100),
      errorWidget: const ColoredBox(color: AppColors.grey200),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date, this.compact = false});

  final DateTime date;
  final bool compact;

  @override
  Widget build(final BuildContext context) {
    final double size = compact ? 44 : 48;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            DateFormat('dd').format(date),
            style: AppTextStyles.bodyBold.copyWith(
              color: AppColors.text500,
              fontSize: compact ? 16 : 18,
              height: 1.1,
            ),
          ),
          Text(
            DateFormat('MMM').format(date),
            style: AppTextStyles.captionRegular.copyWith(
              color: AppColors.text300,
              fontSize: compact ? 10 : 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({required this.onPressed, this.label = 'Join'});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: _kAccentOrange,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            label,
            style: AppTextStyles.bodySmallBold.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class _AccentChip extends StatelessWidget {
  const _AccentChip({required this.label});

  final String label;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _kAccentOrangeSoft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.captionBold.copyWith(color: _kAccentOrange),
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
