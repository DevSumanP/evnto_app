import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import '../../../../shared/widgets/common/avatar_widget.dart';

/// Top block of the profile screen: avatar, name, email, an optional
/// organizer/verified badge, and the Edit button.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEdit,
    this.isUploading = false,
  });

  final UserProfile profile;
  final VoidCallback onEdit;
  final bool isUploading;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Avatar(url: profile.avatarUrl, initials: profile.initials),
            // Dim the avatar and show a spinner while the new photo uploads.
            if (isUploading)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: AppColors.black.withValues(alpha: 0.4),
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      ImageConstants.edit,
                      height: 14,
                      width: 14,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
