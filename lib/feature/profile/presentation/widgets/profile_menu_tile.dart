import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

/// One tappable row in a [ProfileSection]: leading icon, label, optional
/// trailing (chevron by default), optional destructive (red) styling.
class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.trailing,
    this.destructive = false,
  });

  final String icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool destructive;

  // Swap for AppColors.error if your palette defines one.
  static const Color _danger = Color(0xFFE5484D);

  @override
  Widget build(final BuildContext context) {
    final Color fg = destructive ? _danger : AppColors.text500;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(icon, height: 22, width: 22, color: fg),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: fg,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      value,
                      style: AppTextStyles.bodyRegular.copyWith(color: fg),
                    ),
                  ],
                ),
              ),
              trailing ??
                  (onTap != null && !destructive
                      ? const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.text300,
                        )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
