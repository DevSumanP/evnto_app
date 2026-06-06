import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tap_app/core/constants/image_constants.dart';

import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:tap_app/feature/profile/presentation/blocs/profile_bloc.dart';
import 'package:tap_app/feature/profile/presentation/blocs/settings_bloc.dart';
import 'package:tap_app/feature/profile/presentation/pages/edit_profile_page.dart';
import 'package:tap_app/feature/profile/presentation/widgets/profile_header.dart';
import 'package:tap_app/feature/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:tap_app/feature/profile/presentation/widgets/profile_section.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (_) =>
              inject<ProfileBloc>()..add(const ProfileEvent.started()),
        ),
        BlocProvider<SettingsBloc>(
          create: (_) =>
              inject<SettingsBloc>()..add(const SettingsEvent.started()),
        ),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Future<void> _signOut(final BuildContext context) async {
    // Logout clears local credentials and emits SessionSignedOut; the global
    // SessionListener swaps the route, so we do not navigate from here.
    await inject<LogoutUseCase>().call(const NoParams());
  }

  // Let the user pick a photo from the camera or gallery, then hand it to the
  // bloc which uploads it and saves the URL on the profile.
  Future<void> _pickAvatar(final BuildContext context) async {
    final bloc = context.read<ProfileBloc>();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.white,
      builder: (final BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Take a photo'),
                onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () =>
                    Navigator.of(sheetContext).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
    if (source == null) return;

    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 512,
      imageQuality: 80,
    );
    if (picked == null) return;

    bloc.add(ProfileEvent.avatarChangeRequested(File(picked.path)));
  }

  @override
  Widget build(final BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) =>
              previous.notifStatus != current.notifStatus,
          listener: (context, state) {
            if (state.notifStatus == NotifToggleStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.notifError ?? 'Could not update notifications',
                  ),
                ),
              );
            }
          },
        ),
        // Avatar upload is the only thing that sets saveError on this screen's
        // bloc, so surface its failures as a snackbar.
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) =>
              previous.saveError != current.saveError &&
              current.saveError != null,
          listener: (context, state) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.saveError!)));
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          // Material 3 tints the app bar when content scrolls under it. Turn
          // that off so it stays white instead of showing the default color.
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(
            'Profile',
            style: AppTextStyles.h4Bold.copyWith(color: AppColors.text500),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (final BuildContext context, final ProfileState state) {
              if (state.isLoading || state.status == ProfileStatus.idle) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary500),
                );
              }
              if (state.status == ProfileStatus.failure ||
                  state.profile == null) {
                return _ErrorView(
                  message: state.error,
                  onRetry: () => context.read<ProfileBloc>().add(
                    const ProfileEvent.started(),
                  ),
                );
              }

              final profile = state.profile!;
              return RefreshIndicator(
                color: AppColors.primary500,
                onRefresh: () async => context.read<ProfileBloc>().add(
                  const ProfileEvent.refreshed(),
                ),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: <Widget>[
                    ProfileHeader(
                      profile: profile,
                      isUploading: state.isUploadingAvatar,
                      onEdit: () => _pickAvatar(context),
                    ),
                    const SizedBox(height: 24),
                    ProfileSection(
                      title: 'Personal Information',
                      children: <Widget>[
                        ProfileMenuTile(
                          icon: ImageConstants.user,
                          label: 'Your Name',
                          value: profile.displayName,
                          onTap: () => context.router.push(
                            EditProfileRoute(
                              profile: profile,
                              field: EditField.name,
                            ),
                          ),
                        ),
                        ProfileMenuTile(
                          icon: ImageConstants.phone,
                          label: 'Phone Number',
                          value: profile.phone ?? 'Not set',
                          onTap: () => context.router.push(
                            EditProfileRoute(
                              profile: profile,
                              field: EditField.phone,
                            ),
                          ),
                        ),

                        ProfileMenuTile(
                          icon: ImageConstants.email,
                          label: 'Email Address',
                          value: profile.email,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ProfileSection(
                      title: 'Actions',
                      children: <Widget>[
                        ProfileMenuTile(
                          icon: ImageConstants.password,
                          label: 'Change Password ',
                          value: 'Change password for you account',
                          onTap: () => context.router.push(
                            EditProfileRoute(
                              profile: profile,
                              field: EditField.password,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ProfileSection(
                      title: 'Settings',
                      children: <Widget>[
                        ProfileMenuTile(
                          icon: ImageConstants.notification02,
                          label: 'Push notifications',
                          value: 'Event remainders and updates',
                          trailing: BlocBuilder<SettingsBloc, SettingsState>(
                            buildWhen: (p, c) =>
                                p.notificationEnabled != c.notificationEnabled,
                            builder: (context, state) {
                              return Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: state.notificationEnabled,
                                  onChanged: state.isUpdatingNotifications
                                      ? null
                                      : (value) => context.read<SettingsBloc>()
                                          ..add(
                                            SettingsEvent.notificationsToggled(
                                              value,
                                            ),
                                          ),
                                  activeColor: AppColors.primary,
                                  inactiveThumbColor: AppColors.text300,
                                  inactiveTrackColor: AppColors.text50,
                                ),
                              );
                            },
                          ),
                        ),
                        ProfileMenuTile(
                          icon: ImageConstants.language,
                          label: 'Language',
                          value: 'English',
                          onTap: () =>
                              context.router.push(const TicketsRoute()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ProfileMenuTile(
                      icon: ImageConstants.logout,
                      label: 'Logout',
                      value: 'Sign out of account',
                      destructive: true,
                      onTap: () => _signOut(context),
                    ),
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry, this.message});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message ?? 'Could not load your profile.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
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
