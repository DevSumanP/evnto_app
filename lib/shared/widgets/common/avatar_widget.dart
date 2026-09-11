import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.url,
    required this.initials,
    this.size = 100,
  });

  final String? url;
  final double size;
  final String initials;

  @override
  Widget build(final BuildContext context) {
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
