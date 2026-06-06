// ==============================================================================
// lib/feature/explore/presentation/pages/explore_page.dart
// Explore tab. Map-first: an OpenStreetMap with event pins, a search bar +
// location pill + category chips floating on top, and a draggable bottom sheet
// listing the nearby events with a "Join" button. Applying the advanced
// filters (date / price / sort) switches to a scrollable filtered list.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:tap_app/core/constants/image_constants.dart';

import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/explore/domain/entities/explore_filters.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/feature/explore/presentation/blocs/explore_bloc.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_category_chips.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_filter_sheet.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_join_card.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_location_picker.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_map_layer.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_recent_searches.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_result_card.dart';
import 'package:tap_app/feature/explore/presentation/widgets/explore_search_header.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ExploreBloc>(
      create: (_) => inject<ExploreBloc>()..add(const ExploreEvent.started()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatefulWidget {
  const _ExploreView();

  @override
  State<_ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<_ExploreView> {
  final TextEditingController _search = TextEditingController();
  final ScrollController _listScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _listScroll.addListener(_onListScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _resolveInitial());
  }

  @override
  void dispose() {
    _listScroll
      ..removeListener(_onListScroll)
      ..dispose();
    _search.dispose();
    super.dispose();
  }

  ExploreBloc get _bloc => context.read<ExploreBloc>();

  // ── Location ────────────────────────────────────────────────────────────

  Future<void> _resolveInitial() async {
    try {
      final Position p = await _gps();
      if (!mounted) return;
      _bloc.add(
        ExploreEvent.locationResolved(lat: p.latitude, lng: p.longitude),
      );
    } on Object {
      // GPS denied / off — fall back to the default city so the map still works.
      if (!mounted) return;
      final (double, double) ktm = kNepalCities['Kathmandu']!;
      _bloc.add(
        ExploreEvent.locationResolved(
          lat: ktm.$1,
          lng: ktm.$2,
          city: 'Kathmandu',
        ),
      );
    }
  }

  Future<Position> _gps() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Location services are off.';
    }
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      throw 'Location permission denied.';
    }
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 15),
      ),
    );
  }

  Future<void> _changeLocation() async {
    final ExploreLocationChoice? choice = await showExploreLocationPicker(
      context,
    );
    if (choice == null || !mounted) return;
    if (choice.useCurrent) {
      try {
        final Position p = await _gps();
        if (!mounted) return;
        _bloc.add(
          ExploreEvent.locationResolved(lat: p.latitude, lng: p.longitude),
        );
      } on Object {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not get your location.')),
        );
      }
    } else {
      _bloc.add(
        ExploreEvent.locationResolved(
          lat: choice.lat!,
          lng: choice.lng!,
          city: choice.city,
        ),
      );
    }
  }

  // ── List-mode pagination ─────────────────────────────────────────────────

  void _onListScroll() {
    if (!_listScroll.hasClients) return;
    final ExploreState s = _bloc.state;
    if (s.mode != ExploreMode.list ||
        !s.hasMore ||
        s.status == ExploreStatus.loadingMore) {
      return;
    }
    if (_listScroll.position.pixels >=
        _listScroll.position.maxScrollExtent - 400) {
      _bloc.add(const ExploreEvent.loadMore());
    }
  }

  Future<void> _openFilters(final ExploreFilters current) async {
    final ExploreFilters? result = await showExploreFilterSheet(
      context,
      current,
    );
    if (result != null && mounted) {
      _bloc.add(ExploreEvent.filtersApplied(result));
    }
  }

  // ── Map-mode filter chips (client-side) ──────────────────────────────────
  // The nearby feed only supports category + query, so Sort / Date / Price
  // refine the already-loaded events here instead of round-tripping the server.

  ExploreSort _mapSort = ExploreSort.featured;
  DateTimeRange? _mapDates;
  _MapPriceFilter _mapPrice = _MapPriceFilter.any;

  /// Narrows + reorders the nearby events by the active chips. Pins and the
  /// sheet list both render the result.
  List<Event> _applyMapFilters(final List<Event> items) {
    Iterable<Event> out = items;

    if (_mapDates != null) {
      final DateTime from = _mapDates!.start;
      final DateTime to = _mapDates!.end;
      out = out.where((final Event e) {
        final DateTime ends = e.endsAt ?? e.startsAt;
        return !e.startsAt.isAfter(to) && !ends.isBefore(from);
      });
    }
    if (_mapPrice != _MapPriceFilter.any) {
      out = out.where(_mapPrice.matches);
    }

    final List<Event> list = out.toList();
    switch (_mapSort) {
      case ExploreSort.featured:
        break; // keep the nearby (distance) order
      case ExploreSort.dateAsc:
        list.sort((a, b) => a.startsAt.compareTo(b.startsAt));
      case ExploreSort.dateDesc:
        list.sort((a, b) => b.startsAt.compareTo(a.startsAt));
      case ExploreSort.priceAsc:
        list.sort(
          (a, b) => (a.minPricePaisa ?? 1 << 62).compareTo(
            b.minPricePaisa ?? 1 << 62,
          ),
        );
      case ExploreSort.priceDesc:
        list.sort(
          (a, b) => (b.maxPricePaisa ?? -1).compareTo(a.maxPricePaisa ?? -1),
        );
    }
    return list;
  }

  String get _sortChipLabel => switch (_mapSort) {
    ExploreSort.featured => 'Sort',
    ExploreSort.dateAsc => 'Soonest',
    ExploreSort.dateDesc => 'Latest',
    ExploreSort.priceAsc => 'Price: low',
    ExploreSort.priceDesc => 'Price: high',
  };

  String get _dateChipLabel {
    if (_mapDates == null) return 'Date';
    final DateFormat f = DateFormat('d MMM');
    final String s = f.format(_mapDates!.start);
    final String e = f.format(_mapDates!.end);
    return s == e ? s : '$s – $e';
  }

  Widget _mapFilterBar() {
    return SizedBox(
      height: 34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: <Widget>[
          _DropdownChip(
            label: _sortChipLabel,
            active: _mapSort != ExploreSort.featured,
            onTap: _pickMapSort,
          ),
          const SizedBox(width: 8),
          _DropdownChip(
            label: _dateChipLabel,
            active: _mapDates != null,
            onTap: _pickMapDate,
          ),
          const SizedBox(width: 8),
          _DropdownChip(
            label: _mapPrice.chipLabel,
            active: _mapPrice != _MapPriceFilter.any,
            onTap: _pickMapPrice,
          ),
        ],
      ),
    );
  }

  Future<void> _pickMapSort() async {
    final ExploreSort? picked = await _showRadioSheet<ExploreSort>(
      title: 'Sort by',
      options: ExploreSort.values,
      selected: _mapSort,
      labelOf: (final ExploreSort s) => s.label,
    );
    if (picked != null) setState(() => _mapSort = picked);
  }

  Future<void> _pickMapPrice() async {
    final _MapPriceFilter? picked = await _showRadioSheet<_MapPriceFilter>(
      title: 'Price',
      options: _MapPriceFilter.values,
      selected: _mapPrice,
      labelOf: (final _MapPriceFilter p) => p.label,
    );
    if (picked != null) setState(() => _mapPrice = picked);
  }

  Future<void> _pickMapDate() async {
    final String? choice = await _showRadioSheet<String>(
      title: 'Date',
      options: const <String>['Any date', 'Choose dates…'],
      selected: _mapDates == null ? 'Any date' : 'Choose dates…',
      labelOf: (final String s) => s,
    );
    if (choice == null || !mounted) return;
    if (choice == 'Any date') {
      setState(() => _mapDates = null);
      return;
    }
    final DateTime now = DateTime.now();
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      initialDateRange: _mapDates,
    );
    if (range != null) {
      setState(
        () => _mapDates = DateTimeRange(
          start: range.start,
          end: DateTime(
            range.end.year,
            range.end.month,
            range.end.day,
            23,
            59,
            59,
          ),
        ),
      );
    }
  }

  Future<T?> _showRadioSheet<T>({
    required final String title,
    required final List<T> options,
    required final T selected,
    required final String Function(T) labelOf,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (final BuildContext sheetCtx) => SafeArea(
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
                title,
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.text500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              ...options.map(
                (final T o) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(sheetCtx).pop(o),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          o == selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          size: 20,
                          color: o == selected
                              ? _kAccentOrange
                              : AppColors.text300,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          labelOf(o),
                          style: AppTextStyles.bodyRegular.copyWith(
                            color: AppColors.text500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(final BuildContext context) {
    // Let the map run under the status bar on the Explore tab. The shell paints
    // an opaque white status bar; a transparent one here lets the map show
    // through. Dark icons stay readable over the light map tiles.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F5),
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (final BuildContext context, final ExploreState state) =>
              state.mode == ExploreMode.map
              ? _buildMap(state)
              : _buildList(state),
        ),
      ),
    );
  }

  Widget _header(final ExploreState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ExploreSearchHeader(
        controller: _search,
        city: state.city,
        activeFilterCount: state.filters.activeCount,
        onChanged: (q) => _bloc.add(ExploreEvent.queryChanged(q)),
        onSubmitted: (q) => _bloc.add(ExploreEvent.searchSubmitted(q)),
        onClear: () {
          _search.clear();
          _bloc.add(const ExploreEvent.queryChanged(''));
        },
        onLocationTap: _changeLocation,
        onFilterTap: () => _openFilters(state.filters),
      ),
    );
  }

  // ── Map mode ───────────────────────────────────────────────────────────

  Widget _buildMap(final ExploreState state) {
    final List<Event> mapItems = _applyMapFilters(state.mapItems);
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: state.hasCenter
              ? ExploreMapLayer(
                  center: LatLng(state.centerLat!, state.centerLng!),
                  events: mapItems,
                )
              : const ColoredBox(
                  color: Color(0xFFE9ECEF),
                  child: Center(
                    child: CircularProgressIndicator(color: _kAccentOrange),
                  ),
                ),
        ),
        SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                _header(state),
                const SizedBox(height: 12),
                ExploreCategoryChips(
                  selected: state.filters.category,
                  onSelected: (c) =>
                      _bloc.add(ExploreEvent.categorySelected(c)),
                ),
              ],
            ),
          ),
        ),
        DraggableScrollableSheet(
          // Like Google Maps: open as a small header peek, then snap to half,
          // then full as the user drags up.
          initialChildSize: 0.15,
          minChildSize: 0.15,
          maxChildSize: 0.92,
          snap: true,
          snapSizes: const <double>[0.42],
          builder: (final BuildContext _, final ScrollController scroll) =>
              _MapSheet(
                state: state,
                items: mapItems,
                filterBar: _mapFilterBar(),
                scrollController: scroll,
                onRetry: () => _bloc.add(const ExploreEvent.refreshed()),
              ),
        ),
      ],
    );
  }

  // ── List mode (filtered results) ─────────────────────────────────────────

  Widget _buildList(final ExploreState state) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8),
          _header(state),
          const SizedBox(height: 16),
          ExploreCategoryChips(
            selected: state.filters.category,
            onSelected: (c) => _bloc.add(ExploreEvent.categorySelected(c)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Row(
              children: <Widget>[
                Text(
                  'Filtered results',
                  style: AppTextStyles.captionBold.copyWith(
                    color: AppColors.text300,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _bloc.add(const ExploreEvent.modeToggled()),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.map_outlined,
                        size: 16,
                        color: _kAccentOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Map',
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: _kAccentOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _ResultsBody(
              state: state,
              scrollController: _listScroll,
              onRefresh: () async => _bloc.add(const ExploreEvent.refreshed()),
              onRecentTap: (term) {
                _search.text = term;
                _bloc.add(ExploreEvent.searchSubmitted(term));
              },
              onRecentClear: () =>
                  _bloc.add(const ExploreEvent.recentCleared()),
              onRetry: () => _bloc.add(const ExploreEvent.refreshed()),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Map bottom sheet ────────────────────────────────────────────────────────

class _MapSheet extends StatelessWidget {
  const _MapSheet({
    required this.state,
    required this.items,
    required this.filterBar,
    required this.scrollController,
    required this.onRetry,
  });

  final ExploreState state;
  final List<Event> items;
  final Widget filterBar;
  final ScrollController scrollController;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0x1F000000), blurRadius: 16),
        ],
      ),
      child: _content(),
    );
  }

  Widget _content() {
    if (state.mapFirstLoad) {
      return ListView(
        controller: scrollController,
        children: const <Widget>[
          _Handle(),
          SizedBox(height: 40),
          Center(child: CircularProgressIndicator(color: _kAccentOrange)),
        ],
      );
    }
    if (state.mapStatus == ExploreStatus.failure) {
      return ListView(
        controller: scrollController,
        children: <Widget>[
          const _Handle(),
          const SizedBox(height: 24),
          _SheetMessage(
            text: state.mapError ?? 'Could not load nearby events.',
            onRetry: onRetry,
          ),
        ],
      );
    }
    if (items.isEmpty) {
      return ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: <Widget>[
          _SheetHeader(count: 0, filterBar: filterBar),
          const SizedBox(height: 24),
          _SheetMessage(
            text: state.mapItems.isEmpty
                ? 'No events within 20 km.'
                : 'No events match your filters.',
          ),
        ],
      );
    }
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: items.length + 1,
      separatorBuilder: (_, final int i) =>
          i == 0 ? const SizedBox.shrink() : const SizedBox(height: 12),
      itemBuilder: (_, final int i) {
        if (i == 0) {
          return _SheetHeader(count: items.length, filterBar: filterBar);
        }
        return ExploreJoinCard(event: items[i - 1]);
      },
    );
  }
}

/// Handle + a short title, shown at the top of the sheet. When the sheet is
/// collapsed this is all that peeks above the fold, like the Google Maps sheet.
class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.count, required this.filterBar});

  final int count;
  final Widget filterBar;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _Handle(),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Events near me',
                    style: AppTextStyles.h2Medium.copyWith(
                      color: AppColors.text500,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$count within 20 km',
                    style: AppTextStyles.captionBold.copyWith(
                      color: AppColors.text300,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(ImageConstants.close, height: 24, width: 24),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(bottom: 12), child: filterBar),
      ],
    );
  }
}

/// A Google-Maps-style filter chip: a label and a dropdown caret. Filled when
/// its filter is active.
class _DropdownChip extends StatelessWidget {
  const _DropdownChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final Color fg = active ? AppColors.white : AppColors.text500;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _kAccentOrange : AppColors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: active ? _kAccentOrange : AppColors.grey200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label, style: AppTextStyles.bodySmallBold.copyWith(color: fg)),
            Icon(Icons.arrow_drop_down, size: 18, color: fg),
          ],
        ),
      ),
    );
  }
}

/// Price buckets used by the map sheet's Price chip (client-side filter).
enum _MapPriceFilter {
  any('Any price'),
  free('Free'),
  under500('Under Rs 500'),
  mid('Rs 500 – 1000'),
  over1000('Rs 1000+');

  const _MapPriceFilter(this.label);

  final String label;

  /// Chip caption — the default bucket reads as just "Price".
  String get chipLabel => this == _MapPriceFilter.any ? 'Price' : label;

  bool matches(final Event e) {
    switch (this) {
      case _MapPriceFilter.any:
        return true;
      case _MapPriceFilter.free:
        return e.isFree;
      case _MapPriceFilter.under500:
        return e.minPricePaisa != null && e.minPricePaisa! < 50000;
      case _MapPriceFilter.mid:
        return e.minPricePaisa != null &&
            e.minPricePaisa! >= 50000 &&
            e.minPricePaisa! <= 100000;
      case _MapPriceFilter.over1000:
        return e.minPricePaisa != null && e.minPricePaisa! > 100000;
    }
  }
}

class _Handle extends StatelessWidget {
  const _Handle();

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 12),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _SheetMessage extends StatelessWidget {
  const _SheetMessage({required this.text, this.onRetry});

  final String text;
  final VoidCallback? onRetry;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
        ),
        if (onRetry != null)
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Retry',
              style: AppTextStyles.bodySmallBold.copyWith(
                color: _kAccentOrange,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── List-mode results body ──────────────────────────────────────────────────

class _ResultsBody extends StatelessWidget {
  const _ResultsBody({
    required this.state,
    required this.scrollController,
    required this.onRefresh,
    required this.onRecentTap,
    required this.onRecentClear,
    required this.onRetry,
  });

  final ExploreState state;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onRecentTap;
  final VoidCallback onRecentClear;
  final VoidCallback onRetry;

  bool get _queryEmpty => state.filters.query?.trim().isEmpty ?? true;

  @override
  Widget build(final BuildContext context) {
    if (state.isFirstLoad) {
      return const Center(
        child: CircularProgressIndicator(color: _kAccentOrange),
      );
    }
    if (state.status == ExploreStatus.failure && state.items.isEmpty) {
      return _CenteredScroll(
        child: _Message(
          text: state.error ?? 'Could not load events.',
          action: ('Retry', onRetry),
        ),
      );
    }

    final bool showRecent = _queryEmpty && state.recent.isNotEmpty;

    if (state.isEmptyResult) {
      return RefreshIndicator(
        color: _kAccentOrange,
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: <Widget>[
            if (showRecent)
              ExploreRecentSearches(
                terms: state.recent,
                onTap: onRecentTap,
                onClear: onRecentClear,
              ),
            const SizedBox(height: 60),
            _Message(
              text: _queryEmpty
                  ? 'No events found.'
                  : 'No events match your search.',
            ),
          ],
        ),
      );
    }

    final int headerCount = showRecent ? 1 : 0;
    final bool showFooter = state.status == ExploreStatus.loadingMore;
    final int itemCount =
        headerCount + state.items.length + (showFooter ? 1 : 0);

    return RefreshIndicator(
      color: _kAccentOrange,
      onRefresh: onRefresh,
      child: ListView.separated(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        itemCount: itemCount,
        separatorBuilder: (_, final int i) {
          if (showRecent && i == 0) return const SizedBox.shrink();
          return const SizedBox(height: 12);
        },
        itemBuilder: (_, final int i) {
          if (showRecent && i == 0) {
            return ExploreRecentSearches(
              terms: state.recent,
              onTap: onRecentTap,
              onClear: onRecentClear,
            );
          }
          final int index = i - headerCount;
          if (index >= state.items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: _kAccentOrange,
                  ),
                ),
              ),
            );
          }
          return ExploreResultCard(event: state.items[index]);
        },
      ),
    );
  }
}

class _CenteredScroll extends StatelessWidget {
  const _CenteredScroll({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (_, final BoxConstraints c) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: c.maxHeight),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.action});

  final String text;
  final (String, VoidCallback)? action;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
          ),
          if (action != null) ...<Widget>[
            const SizedBox(height: 12),
            TextButton(
              onPressed: action!.$2,
              child: Text(
                action!.$1,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: _kAccentOrange,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
