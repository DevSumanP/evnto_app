import 'package:equatable/equatable.dart';

/// Sort options exposed by the events-search backend
enum ExploreSort { featured, dateAsc, dateDesc, priceAsc, priceDesc }

extension ExploreSortApi on ExploreSort {
  /// The string the backend's string `sort` param expects.
  String get api => switch (this) {
    ExploreSort.featured => 'featured',
    ExploreSort.dateAsc => 'date_asc',
    ExploreSort.dateDesc => 'date_desc',
    ExploreSort.priceAsc => 'price_asc',
    ExploreSort.priceDesc => 'price_desc',
  };

  /// Human label for the filter sheet.
  String get label => switch (this) {
    ExploreSort.featured => 'Featured',
    ExploreSort.dateAsc => 'Date: soonest',
    ExploreSort.dateDesc => 'Date: latest',
    ExploreSort.priceAsc => 'Price: low to high',
    ExploreSort.priceDesc => 'Price: high to low',
  };
}

class ExploreFilters extends Equatable {
  const ExploreFilters({
    this.query,
    this.category,
    this.city,
    this.from,
    this.to,
    this.priceMinPaisa,
    this.priceMaxPaisa,
    this.sort = ExploreSort.featured,
  });

  final String? query;
  final String? category;
  final String? city;
  final DateTime? from;
  final DateTime? to;
  final int? priceMinPaisa;
  final int? priceMaxPaisa;
  final ExploreSort sort;

  /// True when no refinement at all is active - the page shows its browsw
  /// landing instead of a result list in this case.
  bool get isEmpty => (query?.trim().isEmpty ?? true) && activeCount == 0;

  /// Count of active refinements, for the filter-button badge. `query` and
  /// `sort` are excluded — they have their own UI.
  int get activeCount => <Object?>[
    category,
    city,
    from,
    to,
    priceMinPaisa,
    priceMaxPaisa,
  ].where((Object? e) => e != null).length;

  /// Query params for the events-search request. Omits anything unset so the
  /// backend applies its defaults.
  Map<String, dynamic> toQuery({required int page, required int pageSize}) =>
      <String, dynamic>{
        if (query?.trim().isNotEmpty ?? false) 'q': query!.trim(),
        if (category != null) 'category': category,
        if (city != null) 'city': city,
        if (from != null) 'from': from!.toUtc().toIso8601String(),
        if (to != null) 'to': to!.toUtc().toIso8601String(),

        if (priceMinPaisa != null) 'price_min': priceMinPaisa,
        if (priceMaxPaisa != null) 'price_max': priceMaxPaisa,
        'sort': sort.api,
        'page': page,
        'page_size': pageSize,
      };

  /// To clear the text query, pass `query: ''`. For the nullable refinements
  /// use the matching `clearX` flag — passing `null` alone leaves them as-is.
  ExploreFilters copyWith({
    String? query,
    String? category,
    bool clearCategory = false,
    String? city,
    bool clearCity = false,
    DateTime? from,
    DateTime? to,
    bool clearDates = false,
    int? priceMinPaisa,
    int? priceMaxPaisa,
    bool clearPrice = false,
    ExploreSort? sort,
  }) => ExploreFilters(
    query: query ?? this.query,
    category: clearCategory ? null : (category ?? this.category),
    city: clearCity ? null : (city ?? this.city),
    from: clearDates ? null : (from ?? this.from),
    to: clearDates ? null : (to ?? this.to),
    priceMinPaisa: clearPrice ? null : (priceMinPaisa ?? this.priceMinPaisa),
    priceMaxPaisa: clearPrice ? null : (priceMaxPaisa ?? this.priceMaxPaisa),
    sort: sort ?? this.sort,
  );

  @override
  List<Object?> get props => <Object?>[
    query,
    category,
    city,
    from,
    to,
    priceMinPaisa,
    priceMaxPaisa,
    sort,
  ];
}
