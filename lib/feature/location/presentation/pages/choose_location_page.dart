// ==============================================================================
// lib/feature/location/presentation/pages/choose_location_page.dart
// "Choose your location" screen. Shown once after signup and again on login
// if no location is stored. Layout matches the spec:
//
//   [back]
//   Choose your location
//   Let's find your unforgettable event...
//
//   [Search event in...]
//   [Use my current location]
//
//   Popular location
//     Los Angeles   →
//     San Francisco →
//     New York      →
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/shared/widgets/buttons/secondary_button.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/popular_location.dart';
import '../blocs/choose_location_bloc.dart';

@RoutePage()
class ChooseLocationPage extends StatelessWidget {
  const ChooseLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseLocationBloc>(
      create: (_) =>
          inject<ChooseLocationBloc>()
            ..add(const ChooseLocationEvent.started()),
      child: const _ChooseLocationView(),
    );
  }
}

class _ChooseLocationView extends StatefulWidget {
  const _ChooseLocationView();

  @override
  State<_ChooseLocationView> createState() => _ChooseLocationViewState();
}

class _ChooseLocationViewState extends State<_ChooseLocationView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocConsumer<ChooseLocationBloc, ChooseLocationState>(
            listenWhen: (prev, curr) =>
                prev.status != curr.status ||
                prev.failureMessage != curr.failureMessage,
            listener: (context, state) {
              if (state.isSaved) {
                context.router.replaceAll([const MainShellRoute()]);
                return;
              }
              final message = state.failureMessage;
              if (state.status == ChooseLocationStatus.failure &&
                  message != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.errorLight,
                      content: Text(
                        message,
                        style: AppTextStyles.bodySmallMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  );
                context.read<ChooseLocationBloc>().add(
                  const ChooseLocationEvent.errorDismissed(),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.text500,
                        ),
                        onPressed: () => context.router.maybePop(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Choose your location',
                      style: AppTextStyles.h4Bold.copyWith(
                        color: AppColors.text500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Let's find your unforgettable event. Choose a "
                      'location below to get started.',
                      style: AppTextStyles.bodySmallRegular.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _SearchField(
                      controller: _searchController,
                      onChanged: (value) => context
                          .read<ChooseLocationBloc>()
                          .add(ChooseLocationEvent.queryChanged(value)),
                    ),
                    const SizedBox(height: 16),
                    SecondaryButton(
                      label: 'Use my current location',
                      icon: SvgPicture.asset(
                        ImageConstants.currentLocation,
                        color: AppColors.black,
                      ),
                      isLoading: state.isResolvingCurrent,
                      isDisabled: state.isBusy,
                      onPressed: () => context.read<ChooseLocationBloc>().add(
                        const ChooseLocationEvent.useCurrentRequested(),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Popular location',
                      style: AppTextStyles.bodySmallMedium.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(child: _PopularList(state: state)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTextStyles.bodySmallRegular.copyWith(color: AppColors.text500),
      decoration: InputDecoration(
        hintText: 'Search event in...',
        hintStyle: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.text200,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            bottom: 16.0,
            right: 8.0,
          ),
          child: SvgPicture.asset(
            ImageConstants.location,
            color: AppColors.primary,
          ),
        ),
        filled: true,
        fillColor: AppColors.grey100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
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

class _PopularList extends StatelessWidget {
  const _PopularList({required this.state});

  final ChooseLocationState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingPopular) {
      return const Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.2),
        ),
      );
    }

    final List<PopularLocation> items = state.filteredPopular;
    if (items.isEmpty) {
      return Center(
        child: Text(
          state.query.isEmpty
              ? 'No popular cities yet. Pick "Use my current location" instead.'
              : 'No cities match "${state.query}".',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.text300,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      padding: EdgeInsets.zero,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final PopularLocation loc = items[index];
        return _PopularTile(
          location: loc,
          onTap: state.isBusy
              ? null
              : () => context.read<ChooseLocationBloc>().add(
                  ChooseLocationEvent.locationSelected(
                    city: loc.city,
                    country: loc.country,
                  ),
                ),
        );
      },
    );
  }
}

class _PopularTile extends StatelessWidget {
  const _PopularTile({required this.location, required this.onTap});

  final PopularLocation location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.text50),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.city,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if ((location.country ?? '').isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${location.city}, ${location.country!}',
                        style: AppTextStyles.captionRegular.copyWith(
                          color: AppColors.text300,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ImageConstants.locationFilled,
                  height: 24,
                  width: 24,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
