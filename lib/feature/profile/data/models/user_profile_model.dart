import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';

/// Wire model for the row returned by GET /profiles-get. It does not carry
/// the email (that lives in auth.users), so [toEntity] takes the email from
/// the auth session and merges it in.
class UserProfileModel {
  const UserProfileModel({
    required this.id,
    required this.displayName,
    this.avatarUrl,
    this.phone,
    this.city,
    this.country,
    this.role = 'user',
    this.organizerVerified = false,
  });

  final String id;
  final String displayName;
  final String? avatarUrl;
  final String? phone;
  final String? city;
  final String? country;
  final String role;
  final bool organizerVerified;

  factory UserProfileModel.fromJson(final Map<String, dynamic> json) {
    // /profiles-get embeds the caller's organizer (if any) so the screen can
    // show a verified badge. It is null for plain users.
    final Object? org = json['organizers'];
    final Map<String, dynamic>? orgMap = org is Map<String, dynamic>
        ? org
        : null;

    return UserProfileModel(
      id: (json['id'] as String?)?.trim() ?? '',
      displayName: (json['display_name'] as String?)?.trim() ?? '',
      avatarUrl: _nullIfEmpty((json['avatar_url'] as String?)?.trim()),
      phone: _nullIfEmpty((json['phone'] as String?)?.trim()),
      city: _nullIfEmpty((json['city'] as String?)?.trim()),
      country: _nullIfEmpty((json['country'] as String?)?.trim()),
      role: (json['role'] as String?)?.trim() ?? 'user',
      organizerVerified: (orgMap?['verified'] as bool?) ?? false,
    );
  }

  static String? _nullIfEmpty(final String? s) =>
      (s == null || s.isEmpty) ? null : s;

  UserProfile toEntity({required final String email}) => UserProfile(
    id: id,
    displayName: displayName,
    email: email,
    avatarUrl: avatarUrl,
    phone: phone,
    city: city,
    country: country,
    role: role,
    organizerVerified: organizerVerified,
  );
}
