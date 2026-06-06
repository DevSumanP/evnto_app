import 'package:flutter/material.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.imageUrl,
    this.onTap,
    this.trailing,
    this.icon,
  });

  final String title;
  final String subTitle;
  final String? imageUrl;
  final String? icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon or Image thumbnail
          Container(
            width: 48,
            height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: _buildLeading()),
          ),
          const SizedBox(width: 12),

          // Title + subtitle + divider + trailing
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              constraints: const BoxConstraints(minHeight: 62),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.text40, width: 0.7),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title and subtitle column
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.bodySmallMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(subTitle, style: AppTextStyles.captionRegular),
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 24),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeading() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return AppNetworkImage(
        imageUrl!,
        fit: BoxFit.cover,
        errorWidget: _buildPlaceholder(),
      );
    }
    if (icon != null && icon!.isNotEmpty) {
      return Image.asset(icon!, height: 24, width: 24);
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Image.asset(ImageConstants.appIcon, height: 24, width: 24);
  }
}

/// A specialized download button to be used as trailing in CustomTile
class CustomDownloadButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomDownloadButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primary50.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            ImageConstants.appIcon,
            height: 16,
            width: 16,
            color: AppColors.primary500,
          ),
        ),
      ),
    );
  }
}
