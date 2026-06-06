// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_location_picker.dart
// Bottom sheet to choose the map centre: "use my current location" (GPS) or a
// city from a fixed list. Returns the choice via Navigator.pop.
// ==============================================================================

import 'package:flutter/material.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

/// City → coordinates. Nepal-targeted product, so these are the main hubs.
const Map<String, (double lat, double lng)> kNepalCities =
    <String, (double, double)>{
      'Kathmandu': (27.7172, 85.3240),
      'Lalitpur': (27.6588, 85.3247),
      'Bhaktapur': (27.6710, 85.4298),
      'Pokhara': (28.2096, 83.9856),
      'Bharatpur': (27.6766, 84.4333),
      'Janakpur': (26.7271, 85.9407),
      'Biratnagar': (26.4525, 87.2718),
    };

/// The user's pick from the location sheet.
class ExploreLocationChoice {
  const ExploreLocationChoice.currentLocation()
    : useCurrent = true,
      city = null,
      lat = null,
      lng = null;

  const ExploreLocationChoice.city(this.city, this.lat, this.lng)
    : useCurrent = false;

  final bool useCurrent;
  final String? city;
  final double? lat;
  final double? lng;
}

Future<ExploreLocationChoice?> showExploreLocationPicker(
  final BuildContext context,
) {
  return showModalBottomSheet<ExploreLocationChoice>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (final BuildContext sheetCtx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Choose location',
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.text500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.my_location, color: _kAccentOrange),
                title: Text(
                  'Use my current location',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.text500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => Navigator.of(
                  sheetCtx,
                ).pop(const ExploreLocationChoice.currentLocation()),
              ),
              const Divider(height: 8),
              ...kNepalCities.entries.map(
                (final MapEntry<String, (double, double)> e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.location_city,
                    color: AppColors.text300,
                  ),
                  title: Text(
                    e.key,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.text500,
                    ),
                  ),
                  onTap: () => Navigator.of(sheetCtx).pop(
                    ExploreLocationChoice.city(e.key, e.value.$1, e.value.$2),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
