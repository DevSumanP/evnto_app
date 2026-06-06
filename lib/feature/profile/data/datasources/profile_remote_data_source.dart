import 'dart:io' show Platform;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/config/app_config.dart';
import 'package:tap_app/core/constants/api_constants.dart';
import 'package:tap_app/core/errors/exceptions.dart';
import 'package:tap_app/core/network/api_client.dart';
import 'package:tap_app/core/network/api_endpoints.dart';
import 'package:tap_app/feature/profile/data/models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  /// Caller's profile from GET /profiles-get.
  Future<UserProfileModel> getProfile();

  /// Patch the caller's profile via POST /profile-upsert. Only the non-null
  /// fields are sent, so a partial edit changes only what the user touched.
  /// Returns the updated row.
  Future<UserProfileModel> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? phone,
    String? city,
    String? country,
  });

  /// Turn push on (register this device's FCM token) or off (remove it).
  Future<void> setNotifications({required bool enabled});

  /// Anonymize + disable the account via POST /account-delete.
  Future<void> deleteAccount();

  /// Upload avatar bytes straight to the public `user-avatars` bucket under
  /// the caller's uid prefix (the bucket's RLS allows this) and return the
  /// public URL. Use a fresh object name each time so a cached old photo is
  /// never served.
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List bytes,
    required String fileExt,
  });
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl(this._apiClient, this._messaging);

  final ApiClient _apiClient;
  final FirebaseMessaging _messaging;

  @override
  Future<UserProfileModel> getProfile() async {
    final response = await _apiClient.get<dynamic>(ApiEndpoints.profileGet);
    return UserProfileModel.fromJson(_extract(response.data));
  }

  @override
  Future<UserProfileModel> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? phone,
    String? city,
    String? country,
  }) async {
    // Build the patch with only the fields that were provided. Null means
    // "leave unchanged"; the backend rejects a completely empty body.
    final patchData = <String, dynamic>{
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
    };

    final response = await _apiClient.post<dynamic>(
      ApiEndpoints.profile,
      data: patchData,
    );
    return UserProfileModel.fromJson(_extract(response.data));
  }

  @override
  Future<void> setNotifications({required bool enabled}) async {
    if (!enabled) {
      // Off: drop this device's token(s) so broadcasts skip the user.
      await _apiClient.post<dynamic>(
        ApiEndpoints.unregisterDevice,
        data: <String, dynamic>{},
      );
      return;
    }

    // On: re-register the current FCM token. Null token (e.g. emulator with
    // no Play Services) means nothing to register.
    final token = await _messaging.getToken();
    if (token == null) return;

    final platform = Platform.isAndroid
        ? 'android'
        : Platform.isIOS
        ? 'ios'
        : 'web';

    await _apiClient.post<dynamic>(
      ApiEndpoints.registerDevice,
      data: <String, dynamic>{'fcm_token': token, 'platform': platform},
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _apiClient.post<dynamic>(
      ApiEndpoints.accountDelete,
      data: <String, dynamic>{},
    );
  }

  @override
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List bytes,
    required String fileExt,
  }) async {
    // Unique name per upload so the CDN / Image.network never serves a stale
    // photo for the same path.
    final objectPath = '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}'
        '.$fileExt';
    final base = AppConfig.supabaseUrl;

    // Absolute URL on the supabase host: the auth interceptor still attaches
    // the bearer (same as the auth data source), and we force the apikey
    // header that the storage API also expects.
    await _apiClient.post<dynamic>(
      '$base/storage/v1/object/user-avatars/$objectPath',
      data: Stream<List<int>>.fromIterable(<List<int>>[bytes]),
      options: Options(
        headers: <String, dynamic>{
          'x-upsert': 'true',
          Headers.contentLengthHeader: bytes.length,
          if (AppConfig.supabaseAnonKey.isNotEmpty)
            ApiConstants.supabaseApiKey: AppConfig.supabaseAnonKey,
        },
        contentType: 'image/$fileExt',
      ),
    );

    return '$base/storage/v1/object/public/user-avatars/$objectPath';
  }
}

/// Both profile endpoints wrap the row in a top-level `data` envelope (the
/// backend `ok(...)` helper). Unwrap it, tolerating a bare object too.
Map<String, dynamic> _extract(final dynamic body) {
  if (body is Map<String, dynamic>) {
    final dynamic inner = body['data'];
    if (inner is Map<String, dynamic>) return inner;
    return body;
  }
  throw const JsonParsingException(
    message: 'Unexpected response shape for profile',
  );
}
