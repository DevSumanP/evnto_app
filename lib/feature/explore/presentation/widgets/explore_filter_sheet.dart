// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_filter_sheet.dart
// Bottom sheet for the Explore refinements: city, date range, price range,
// and sort. Returns the edited ExploreFilters via Navigator.pop, or null when
// dismissed. "Clear all" resets the refinements but keeps the text query.
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/explore/domain/entities/explore_filters.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

// Price slider runs 0 .. 5000 rupees (in paisa). The top of the range reads
// as "no upper limit".
const double _kMaxPriceRupees = 5000;

/// Common Nepali cities for quick selection (Nepal-targeted product).
const List<String> _kCities = <String>[
  'Kathmandu',
  'Lalitpur',
  'Bhaktapur',
  'Pokhara',
  'Bharatpur',
  'Janakpur',
];

Future<ExploreFilters?> showExploreFilterSheet(
  final BuildContext context,
  final ExploreFilters initial,
) {
  return showModalBottomSheet<ExploreFilters>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _FilterSheet(initial: initial),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.initial});

  final ExploreFilters initial;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String? _city = widget.initial.city;
  late DateTime? _from = widget.initial.from;
  late DateTime? _to = widget.initial.to;
  late ExploreSort _sort = widget.initial.sort;
  late RangeValues _price = RangeValues(
    (widget.initial.priceMinPaisa ?? 0) / 100,
    (widget.initial.priceMaxPaisa ?? (_kMaxPriceRupees * 100)) / 100,
  );

  bool get _priceTouched => _price.start > 0 || _price.end < _kMaxPriceRupees;

  @override
  Widget build(final BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Filters',
                  style: AppTextStyles.h4Bold.copyWith(
                    color: AppColors.text500,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: _clearAll,
                  child: Text(
                    'Clear all',
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: _kAccentOrange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _SectionLabel('City'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _kCities
                  .map(
                    (final String c) => _ChoicePill(
                      label: c,
                      selected: _city == c,
                      onTap: () =>
                          setState(() => _city = _city == c ? null : c),
                    ),
                  )
                  .toList(growable: false),
            ),
            const SizedBox(height: 20),

            _SectionLabel('Date'),
            const SizedBox(height: 8),
            _RowButton(
              label: _dateLabel(),
              onTap: _pickDates,
              onClear: (_from != null || _to != null)
                  ? () => setState(() {
                      _from = null;
                      _to = null;
                    })
                  : null,
            ),
            const SizedBox(height: 20),

            _SectionLabel('Price (Rs)'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _priceTouched
                      ? 'Rs ${_price.start.round()} – ${_price.end.round()}'
                      : 'Any price',
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.text500,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: _price,
              min: 0,
              max: _kMaxPriceRupees,
              divisions: 50,
              activeColor: _kAccentOrange,
              labels: RangeLabels(
                'Rs ${_price.start.round()}',
                'Rs ${_price.end.round()}',
              ),
              onChanged: (final RangeValues v) => setState(() => _price = v),
            ),
            const SizedBox(height: 12),

            _SectionLabel('Sort by'),
            const SizedBox(height: 8),
            ...ExploreSort.values.map(
              (final ExploreSort s) => _SortOption(
                label: s.label,
                selected: _sort == s,
                onTap: () => setState(() => _sort = s),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kAccentOrange,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _apply,
                child: Text(
                  'Apply',
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _dateLabel() {
    if (_from == null && _to == null) return 'Any date';
    final DateFormat f = DateFormat('d MMM');
    if (_from != null && _to != null) {
      return '${f.format(_from!)} – ${f.format(_to!)}';
    }
    return f.format(_from ?? _to!);
  }

  Future<void> _pickDates() async {
    final DateTime now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      initialDateRange: (_from != null && _to != null)
          ? DateTimeRange(start: _from!, end: _to!)
          : null,
    );
    if (picked != null) {
      setState(() {
        _from = picked.start;
        // Include the whole end day.
        _to = DateTime(
          picked.end.year,
          picked.end.month,
          picked.end.day,
          23,
          59,
          59,
        );
      });
    }
  }

  void _clearAll() {
    setState(() {
      _city = null;
      _from = null;
      _to = null;
      _price = const RangeValues(0, _kMaxPriceRupees);
      _sort = ExploreSort.featured;
    });
  }

  void _apply() {
    Navigator.of(context).pop(
      ExploreFilters(
        query: widget.initial.query,
        category: widget.initial.category,
        city: _city,
        from: _from,
        to: _to,
        priceMinPaisa: _price.start > 0 ? (_price.start * 100).round() : null,
        priceMaxPaisa: _price.end < _kMaxPriceRupees
            ? (_price.end * 100).round()
            : null,
        sort: _sort,
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  const _SortOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: <Widget>[
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20,
              color: selected ? _kAccentOrange : AppColors.text300,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.text500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(final BuildContext context) => Text(
    text,
    style: AppTextStyles.bodySmallBold.copyWith(color: AppColors.text500),
  );
}

class _ChoicePill extends StatelessWidget {
  const _ChoicePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _kAccentOrange : AppColors.greyscale25,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmallBold.copyWith(
            color: selected ? AppColors.white : AppColors.text500,
          ),
        ),
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  const _RowButton({required this.label, required this.onTap, this.onClear});

  final String label;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.greyscale25,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.event, size: 18, color: AppColors.text300),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.text500,
                ),
              ),
            ),
            if (onClear != null)
              GestureDetector(
                onTap: onClear,
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.text300,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
