import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

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
            _Avatar(url: profile.avatarUrl, initials: profile.initials),
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.initials});

  final String? url;
  final String initials;

  @override
  Widget build(final BuildContext context) {
    const double size = 100;
    if (url != null && url!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: AppNetworkImage(
          url!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorWidget: _InitialsCircle(initials: initials, size: size),
        ),
      );
    }
    return _InitialsCircle(initials: initials, size: size);
  }
}

class _InitialsCircle extends StatelessWidget {
  const _InitialsCircle({required this.initials, required this.size});

  final String initials;
  final double size;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.text10,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: AppTextStyles.h4Bold.copyWith(
          color: AppColors.text500,
          fontSize: 28,
        ),
      ),
    );
  }
}
