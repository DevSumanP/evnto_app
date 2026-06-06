import 'package:flutter/material.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.location,
    required this.phone,
    this.email,
    this.width = 343,
    this.backgroundColor = Colors.white,
    this.iconBackgroundColor = const Color(0xFFF1F5F9),
    this.titleColor = const Color(0xFF0F172A),
    this.locationColor = const Color(0xFF3F4555),
    this.phoneColor = const Color(0xFFC41B29),
    this.titleStyle,
    this.locationStyle,
    this.phoneStyle,
    this.icon,
    this.onTap,
  });

  /// Primary label shown in bold at the top.
  final String title;

  /// Location subtitle (e.g. "Lalitpur, Nepal").
  final String location;

  final String? email;

  /// Phone number subtitle (e.g. "01-552111").
  final String phone;

  /// Card width. Defaults to 343.
  final double width;

  // ── Colors ──────────────────────────────────────────────
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color titleColor;
  final Color locationColor;
  final Color phoneColor;

  // ── Optional style overrides ─────────────────────────────
  final TextStyle? titleStyle;
  final TextStyle? locationStyle;
  final TextStyle? phoneStyle;

  /// Replace the default map illustration with any widget.
  final String? icon;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _IconBox(
                backgroundColor: iconBackgroundColor,
                child: _Illustration(icon: icon!),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:
                          titleStyle ??
                          AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.text500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: location,
                      color: locationColor,
                      style: locationStyle,
                    ),
                    const SizedBox(height: 4),
                    if (email != null) ...[
                      _InfoRow(
                        icon: Icons.email_outlined,
                        label: email!,
                        color: AppColors.primarymain,
                        style: AppTextStyles.captionRegular.copyWith(
                          color: AppColors.primarymain,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      label: phone,
                      color: AppColors.secondary500,
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.secondary500,
                      ),
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

// ─────────────────────────────────────────────────────────────
// Private sub-widgets
// ─────────────────────────────────────────────────────────────

class _IconBox extends StatelessWidget {
  const _IconBox({required this.backgroundColor, required this.child});

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: child),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.color,
    this.style,
  });

  final IconData icon;
  final String label;
  final Color color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style:
                style ??
                AppTextStyles.captionRegular.copyWith(color: AppColors.text400),
          ),
        ),
      ],
    );
  }
}

class _Illustration extends StatelessWidget {
  final String icon;
  const _Illustration({required this.icon});

  @override
  Widget build(BuildContext context) {
    final isNetwork = icon.startsWith('http') || icon.startsWith('https');

    return SizedBox(
      width: 32,
      height: 32,
      child: isNetwork
          ? AppNetworkImage(
              icon,
              errorWidget: Image.asset(ImageConstants.appIcon),
            )
          : Image.asset(
              icon,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(ImageConstants.appIcon);
              },
            ),
    );
  }
}
