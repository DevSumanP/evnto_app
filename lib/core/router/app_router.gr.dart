// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChooseLocationPage]
class ChooseLocationRoute extends PageRouteInfo<void> {
  const ChooseLocationRoute({List<PageRouteInfo>? children})
    : super(ChooseLocationRoute.name, initialChildren: children);

  static const String name = 'ChooseLocationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChooseLocationPage();
    },
  );
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    required UserProfile profile,
    required EditField field,
    List<PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(key: key, profile: profile, field: field),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return EditProfilePage(
        key: args.key,
        profile: args.profile,
        field: args.field,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.profile,
    required this.field,
  });

  final Key? key;

  final UserProfile profile;

  final EditField field;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, profile: $profile, field: $field}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditProfileRouteArgs) return false;
    return key == other.key && profile == other.profile && field == other.field;
  }

  @override
  int get hashCode => key.hashCode ^ profile.hashCode ^ field.hashCode;
}

/// generated route for
/// [EventDetailPage]
class EventDetailRoute extends PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    Key? key,
    required String eventId,
    List<PageRouteInfo>? children,
  }) : super(
         EventDetailRoute.name,
         args: EventDetailRouteArgs(key: key, eventId: eventId),
         rawPathParams: {'id': eventId},
         initialChildren: children,
       );

  static const String name = 'EventDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventDetailRouteArgs>(
        orElse: () => EventDetailRouteArgs(eventId: pathParams.getString('id')),
      );
      return EventDetailPage(key: args.key, eventId: args.eventId);
    },
  );
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({this.key, required this.eventId});

  final Key? key;

  final String eventId;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventDetailRouteArgs) return false;
    return key == other.key && eventId == other.eventId;
  }

  @override
  int get hashCode => key.hashCode ^ eventId.hashCode;
}

/// generated route for
/// [ExplorePage]
class ExploreRoute extends PageRouteInfo<void> {
  const ExploreRoute({List<PageRouteInfo>? children})
    : super(ExploreRoute.name, initialChildren: children);

  static const String name = 'ExploreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExplorePage();
    },
  );
}

/// generated route for
/// [FavoritePage]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
    : super(FavoriteRoute.name, initialChildren: children);

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritePage();
    },
  );
}

/// generated route for
/// [GetTicketPage]
class GetTicketRoute extends PageRouteInfo<GetTicketRouteArgs> {
  GetTicketRoute({
    Key? key,
    required String eventId,
    List<PageRouteInfo>? children,
  }) : super(
         GetTicketRoute.name,
         args: GetTicketRouteArgs(key: key, eventId: eventId),
         rawPathParams: {'id': eventId},
         initialChildren: children,
       );

  static const String name = 'GetTicketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GetTicketRouteArgs>(
        orElse: () => GetTicketRouteArgs(eventId: pathParams.getString('id')),
      );
      return GetTicketPage(key: args.key, eventId: args.eventId);
    },
  );
}

class GetTicketRouteArgs {
  const GetTicketRouteArgs({this.key, required this.eventId});

  final Key? key;

  final String eventId;

  @override
  String toString() {
    return 'GetTicketRouteArgs{key: $key, eventId: $eventId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GetTicketRouteArgs) return false;
    return key == other.key && eventId == other.eventId;
  }

  @override
  int get hashCode => key.hashCode ^ eventId.hashCode;
}

/// generated route for
/// [HomePage]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MainShellPage]
class MainShellRoute extends PageRouteInfo<void> {
  const MainShellRoute({List<PageRouteInfo>? children})
    : super(MainShellRoute.name, initialChildren: children);

  static const String name = 'MainShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainShellPage();
    },
  );
}

/// generated route for
/// [NoInternetWidget]
class NoInternetRoute extends PageRouteInfo<NoInternetRouteArgs> {
  NoInternetRoute({
    Key? key,
    VoidCallback? onRetry,
    List<PageRouteInfo>? children,
  }) : super(
         NoInternetRoute.name,
         args: NoInternetRouteArgs(key: key, onRetry: onRetry),
         initialChildren: children,
       );

  static const String name = 'NoInternetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoInternetRouteArgs>(
        orElse: () => const NoInternetRouteArgs(),
      );
      return NoInternetWidget(key: args.key, onRetry: args.onRetry);
    },
  );
}

class NoInternetRouteArgs {
  const NoInternetRouteArgs({this.key, this.onRetry});

  final Key? key;

  final VoidCallback? onRetry;

  @override
  String toString() {
    return 'NoInternetRouteArgs{key: $key, onRetry: $onRetry}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NoInternetRouteArgs) return false;
    return key == other.key && onRetry == other.onRetry;
  }

  @override
  int get hashCode => key.hashCode ^ onRetry.hashCode;
}

/// generated route for
/// [NotFoundPage]
class NotFoundRoute extends PageRouteInfo<void> {
  const NotFoundRoute({List<PageRouteInfo>? children})
    : super(NotFoundRoute.name, initialChildren: children);

  static const String name = 'NotFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotFoundPage();
    },
  );
}

/// generated route for
/// [OnBoardPage]
class OnBoardRoute extends PageRouteInfo<void> {
  const OnBoardRoute({List<PageRouteInfo>? children})
    : super(OnBoardRoute.name, initialChildren: children);

  static const String name = 'OnBoardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnBoardPage();
    },
  );
}

/// generated route for
/// [OrderCompletePage]
class OrderCompleteRoute extends PageRouteInfo<OrderCompleteRouteArgs> {
  OrderCompleteRoute({
    Key? key,
    required String orderId,
    List<PageRouteInfo>? children,
  }) : super(
         OrderCompleteRoute.name,
         args: OrderCompleteRouteArgs(key: key, orderId: orderId),
         rawPathParams: {'id': orderId},
         initialChildren: children,
       );

  static const String name = 'OrderCompleteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OrderCompleteRouteArgs>(
        orElse: () =>
            OrderCompleteRouteArgs(orderId: pathParams.getString('id')),
      );
      return OrderCompletePage(key: args.key, orderId: args.orderId);
    },
  );
}

class OrderCompleteRouteArgs {
  const OrderCompleteRouteArgs({this.key, required this.orderId});

  final Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderCompleteRouteArgs{key: $key, orderId: $orderId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderCompleteRouteArgs) return false;
    return key == other.key && orderId == other.orderId;
  }

  @override
  int get hashCode => key.hashCode ^ orderId.hashCode;
}

/// generated route for
/// [OrderReviewPage]
class OrderReviewRoute extends PageRouteInfo<OrderReviewRouteArgs> {
  OrderReviewRoute({
    Key? key,
    required String eventId,
    required List<CartItem> items,
    required BuyerDto buyer,
    List<PageRouteInfo>? children,
  }) : super(
         OrderReviewRoute.name,
         args: OrderReviewRouteArgs(
           key: key,
           eventId: eventId,
           items: items,
           buyer: buyer,
         ),
         rawPathParams: {'id': eventId},
         initialChildren: children,
       );

  static const String name = 'OrderReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderReviewRouteArgs>();
      return OrderReviewPage(
        key: args.key,
        eventId: args.eventId,
        items: args.items,
        buyer: args.buyer,
      );
    },
  );
}

class OrderReviewRouteArgs {
  const OrderReviewRouteArgs({
    this.key,
    required this.eventId,
    required this.items,
    required this.buyer,
  });

  final Key? key;

  final String eventId;

  final List<CartItem> items;

  final BuyerDto buyer;

  @override
  String toString() {
    return 'OrderReviewRouteArgs{key: $key, eventId: $eventId, items: $items, buyer: $buyer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderReviewRouteArgs) return false;
    return key == other.key &&
        eventId == other.eventId &&
        const ListEquality<CartItem>().equals(items, other.items) &&
        buyer == other.buyer;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      eventId.hashCode ^
      const ListEquality<CartItem>().hash(items) ^
      buyer.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [SuccessPage]
class SuccessRoute extends PageRouteInfo<SuccessRouteArgs> {
  SuccessRoute({
    Key? key,
    Widget? icon,
    String title = 'Successfully Submitted',
    String subtitle =
        'Your request has been successfully submitted.\nYou will be notified once it is reviewed.',
    String buttonLabel = 'Done',
    required VoidCallback onButtonPressed,
    Color backgroundColor = const Color(0xFFF1F5F9),
    List<PageRouteInfo>? children,
  }) : super(
         SuccessRoute.name,
         args: SuccessRouteArgs(
           key: key,
           icon: icon,
           title: title,
           subtitle: subtitle,
           buttonLabel: buttonLabel,
           onButtonPressed: onButtonPressed,
           backgroundColor: backgroundColor,
         ),
         initialChildren: children,
       );

  static const String name = 'SuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuccessRouteArgs>();
      return SuccessPage(
        key: args.key,
        icon: args.icon,
        title: args.title,
        subtitle: args.subtitle,
        buttonLabel: args.buttonLabel,
        onButtonPressed: args.onButtonPressed,
        backgroundColor: args.backgroundColor,
      );
    },
  );
}

class SuccessRouteArgs {
  const SuccessRouteArgs({
    this.key,
    this.icon,
    this.title = 'Successfully Submitted',
    this.subtitle =
        'Your request has been successfully submitted.\nYou will be notified once it is reviewed.',
    this.buttonLabel = 'Done',
    required this.onButtonPressed,
    this.backgroundColor = const Color(0xFFF1F5F9),
  });

  final Key? key;

  final Widget? icon;

  final String title;

  final String subtitle;

  final String buttonLabel;

  final VoidCallback onButtonPressed;

  final Color backgroundColor;

  @override
  String toString() {
    return 'SuccessRouteArgs{key: $key, icon: $icon, title: $title, subtitle: $subtitle, buttonLabel: $buttonLabel, onButtonPressed: $onButtonPressed, backgroundColor: $backgroundColor}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SuccessRouteArgs) return false;
    return key == other.key &&
        icon == other.icon &&
        title == other.title &&
        subtitle == other.subtitle &&
        buttonLabel == other.buttonLabel &&
        onButtonPressed == other.onButtonPressed &&
        backgroundColor == other.backgroundColor;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      icon.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      buttonLabel.hashCode ^
      onButtonPressed.hashCode ^
      backgroundColor.hashCode;
}

/// generated route for
/// [TicketDetailPage]
class TicketDetailRoute extends PageRouteInfo<TicketDetailRouteArgs> {
  TicketDetailRoute({
    Key? key,
    required String ticketId,
    required TicketEntity ticket,
    List<PageRouteInfo>? children,
  }) : super(
         TicketDetailRoute.name,
         args: TicketDetailRouteArgs(
           key: key,
           ticketId: ticketId,
           ticket: ticket,
         ),
         rawPathParams: {'id': ticketId},
         initialChildren: children,
       );

  static const String name = 'TicketDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketDetailRouteArgs>();
      return TicketDetailPage(
        key: args.key,
        ticketId: args.ticketId,
        ticket: args.ticket,
      );
    },
  );
}

class TicketDetailRouteArgs {
  const TicketDetailRouteArgs({
    this.key,
    required this.ticketId,
    required this.ticket,
  });

  final Key? key;

  final String ticketId;

  final TicketEntity ticket;

  @override
  String toString() {
    return 'TicketDetailRouteArgs{key: $key, ticketId: $ticketId, ticket: $ticket}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TicketDetailRouteArgs) return false;
    return key == other.key &&
        ticketId == other.ticketId &&
        ticket == other.ticket;
  }

  @override
  int get hashCode => key.hashCode ^ ticketId.hashCode ^ ticket.hashCode;
}

/// generated route for
/// [TicketQrPage]
class TicketQrRoute extends PageRouteInfo<TicketQrRouteArgs> {
  TicketQrRoute({
    Key? key,
    required String ticketId,
    required TicketEntity ticket,
    List<PageRouteInfo>? children,
  }) : super(
         TicketQrRoute.name,
         args: TicketQrRouteArgs(key: key, ticketId: ticketId, ticket: ticket),
         rawPathParams: {'id': ticketId},
         initialChildren: children,
       );

  static const String name = 'TicketQrRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketQrRouteArgs>();
      return TicketQrPage(
        key: args.key,
        ticketId: args.ticketId,
        ticket: args.ticket,
      );
    },
  );
}

class TicketQrRouteArgs {
  const TicketQrRouteArgs({
    this.key,
    required this.ticketId,
    required this.ticket,
  });

  final Key? key;

  final String ticketId;

  final TicketEntity ticket;

  @override
  String toString() {
    return 'TicketQrRouteArgs{key: $key, ticketId: $ticketId, ticket: $ticket}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TicketQrRouteArgs) return false;
    return key == other.key &&
        ticketId == other.ticketId &&
        ticket == other.ticket;
  }

  @override
  int get hashCode => key.hashCode ^ ticketId.hashCode ^ ticket.hashCode;
}

/// generated route for
/// [TicketsPage]
class TicketsRoute extends PageRouteInfo<void> {
  const TicketsRoute({List<PageRouteInfo>? children})
    : super(TicketsRoute.name, initialChildren: children);

  static const String name = 'TicketsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TicketsPage();
    },
  );
}

/// generated route for
/// [UnderMaintenancePage]
class UnderMaintenanceRoute extends PageRouteInfo<void> {
  const UnderMaintenanceRoute({List<PageRouteInfo>? children})
    : super(UnderMaintenanceRoute.name, initialChildren: children);

  static const String name = 'UnderMaintenanceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UnderMaintenancePage();
    },
  );
}
