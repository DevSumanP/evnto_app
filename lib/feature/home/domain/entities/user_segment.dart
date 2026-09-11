enum UserSegment { newcomer, explorer, regular }

/// Lifecycle bucket from local engagement signals (RFM-lite)
/// Order matters: regular wins overexplorer wins over newcomer
UserSegment resolveSegment({
  required int ticketsCount,
  required int favoritesCount,
  required int activeDays,
  required bool hasUpcomingTicket,
}) {
  if (ticketsCount >= 2 || activeDays >= 5) {
    return UserSegment.regular;
  }
  if (ticketsCount >= 1 || favoritesCount >= 1) {
    return UserSegment.explorer;
  }
  return UserSegment.newcomer;
}
