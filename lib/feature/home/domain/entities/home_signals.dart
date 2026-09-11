// ==============================================================================
// lib/feature/home/domain/entities/home_signals.dart
// Local engagement signals gathered on Home open. In Phase A they pick which
// mock layout to load; in Phase B they become the POST body the edge function
// reads to compute the segment.
// ==============================================================================

import 'package:equatable/equatable.dart';

class HomeSignals extends Equatable {
  const HomeSignals({
    required this.ticketsCount,
    required this.favoritesCount,
    required this.activeDays,
    required this.hasUpcomingTicket,
    this.interests = const <String>[],
    this.city,
  });

  final int ticketsCount;
  final int favoritesCount;
  final int activeDays;
  final bool hasUpcomingTicket;
  final List<String> interests;
  final String? city;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tickets': ticketsCount,
    'favorites': favoritesCount,
    'activeDays': activeDays,
    'hasUpcoming': hasUpcomingTicket,
    'interests': interests,
    if (city != null) 'city': city,
  };

  @override
  List<Object?> get props => <Object?>[
    ticketsCount,
    favoritesCount,
    activeDays,
    hasUpcomingTicket,
    interests,
    city,
  ];
}
