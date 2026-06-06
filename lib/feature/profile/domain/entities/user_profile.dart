import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    required this.avatarUrl,
    required this.phone,
    required this.city,
    required this.country,
    required this.role,
    required this.organizerVerified,
  });

  final String id;
  final String displayName;
  final String email;
  final String? avatarUrl;
  final String? phone;
  final String? city;
  final String? country;
  final String role; // 'user  | 'organizer' | 'admin'
  final bool organizerVerified;

  @override
  List<Object?> get props => [
    id,
    displayName,
    email,
    avatarUrl,
    phone,
    city,
    country,
    role,
    organizerVerified,
  ];

  bool get isOrganizer => role == 'organizer' || role == 'admin';

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty || parts.first.isEmpty) return '?';

    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';

    return (first + last).toUpperCase();
  }
}
