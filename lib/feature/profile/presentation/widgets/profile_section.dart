import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

/// A titled group of rows on a card. Used to cluster the profile menu
/// (Activity, Settings, etc.).
class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Text(
            title,
            style: AppTextStyles.captionBold.copyWith(color: AppColors.text300),
          ),
        ),
        Column(children: _withDividers(children)),
      ],
    );
  }

  List<Widget> _withDividers(final List<Widget> tiles) {
    final out = <Widget>[];
    for (var i = 0; i < tiles.length; i++) {
      out.add(tiles[i]);
      if (i != tiles.length - 1) {
        out.add(const Divider(height: 1, indent: 52, color: AppColors.grey100));
      }
    }
    return out;
  }
}
