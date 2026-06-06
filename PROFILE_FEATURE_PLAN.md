# Profile Feature — Implementation Plan

User-side profile section for **tap_app**. Organizer area is intentionally
**deferred** (not in this plan). Backend endpoints are already built and
deployed; this document is the app-side build guide, phase by phase.

> Convention reference (copy the existing patterns):
> - Data source: `lib/feature/favorite/data/datasources/favorite_remote_data_source.dart`
> - Repository + impl: `favorite_repository.dart` / `favorite_repository_impl.dart`
> - Use case: `lib/feature/favorite/domain/usecases/toggle_favorite_use_case.dart`
> - Cubit + state: `lib/feature/favorite/presentation/blocs/favorites_list_cubit.dart`
> - Page: `@RoutePage()`, `AppColors`, `AppTextStyles`, `inject<T>()`
> - DI is annotation-driven; run `dart run build_runner build --delete-conflicting-outputs` after adding `@injectable`/`@lazySingleton`/`@LazySingleton(as:)` classes.

---

## Backend endpoints (all deployed on `zbsxngixjdbrizubqqhs`)

| Endpoint | Method | Used by | Status |
|---|---|---|---|
| `/profiles-get` | GET | Phase 1 header | ✅ |
| `/profile-upsert` | POST | Phase 1 edit | ✅ (already wired as `ApiEndpoints.profile`) |
| `/orders-mine` | GET | Phase 2 order history | ✅ |
| `/tickets-mine` | GET | Phase 2 link | ✅ (`ApiEndpoints.myTickets`) |
| `/favorites-list` | GET | Phase 2 link | ✅ (`ApiEndpoints.favoritesList`) |
| `/push-register` | POST | Phase 3 notif ON | ✅ (`ApiEndpoints.registerDevice`) |
| `/push-unregister` | POST | Phase 3 notif OFF | ✅ |
| `/account-delete` | POST | Phase 4 delete | ✅ |

### Endpoint constants to add up front

`lib/core/constants/api_constants.dart`:
```dart
static const String profileGet       = '/profiles-get';
static const String ordersMine       = '/orders-mine';
static const String unregisterDevice = '/push-unregister';
static const String accountDelete    = '/account-delete';
```
`lib/core/network/api_endpoints.dart`:
```dart
static const String profileGet       = ApiConstants.profileGet;
static const String ordersMine       = ApiConstants.ordersMine;
static const String unregisterDevice = ApiConstants.unregisterDevice;
static const String accountDelete    = ApiConstants.accountDelete;
```

---

## Final folder structure (all phases)

```
lib/feature/profile/
├── domain/
│   ├── entities/
│   │   ├── user_profile.dart            # P1
│   │   └── order_summary.dart           # P2
│   ├── repositories/
│   │   └── profile_repository.dart      # P1 (extended P2/P4)
│   └── usecases/
│       ├── get_profile_use_case.dart    # P1
│       ├── update_profile_use_case.dart # P1
│       ├── get_my_orders_use_case.dart  # P2
│       ├── set_notifications_use_case.dart  # P3
│       └── delete_account_use_case.dart # P4
├── data/
│   ├── models/
│   │   ├── user_profile_model.dart      # P1
│   │   └── order_summary_model.dart     # P2
│   ├── datasources/
│   │   └── profile_remote_data_source.dart   # P1 (grows each phase)
│   └── repositories/
│       └── profile_repository_impl.dart      # P1 (grows each phase)
└── presentation/
    ├── blocs/
    │   ├── profile_cubit.dart           # P1
    │   ├── order_history_cubit.dart     # P2
    │   └── settings_cubit.dart          # P3
    ├── pages/
    │   ├── profile_page.dart            # P1 (rewrite placeholder)
    │   ├── edit_profile_page.dart       # P1
    │   ├── order_history_page.dart      # P2
    │   ├── settings_page.dart           # P3
    │   └── about_page.dart              # P4
    └── widgets/
        ├── profile_header.dart          # P1
        ├── profile_menu_tile.dart       # P1
        └── profile_section.dart         # P1 (titled group)
```

### Routes to register in `lib/core/router/app_router.dart`
```dart
AutoRoute(page: EditProfileRoute.page,  path: '/profile/edit'),
AutoRoute(page: OrderHistoryRoute.page, path: '/profile/orders'),
AutoRoute(page: SettingsRoute.page,     path: '/profile/settings'),
AutoRoute(page: AboutRoute.page,        path: '/profile/about'),
```
(`ProfileRoute` already exists as a shell tab.)

---

## Phase 1 — Core shell

**Goal:** load the real profile, show header + menu, edit profile, keep sign out.

### 1.1 Entity — `domain/entities/user_profile.dart`
```dart
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    this.avatarUrl,
    this.phone,
    this.city,
    this.country,
    this.role = 'user',
    this.organizerVerified = false,
  });

  final String id;
  final String displayName;
  final String email;
  final String? avatarUrl;
  final String? phone;
  final String? city;
  final String? country;
  final String role;            // 'user' | 'organizer' | 'admin'
  final bool organizerVerified;

  bool get isOrganizer => role == 'organizer' || role == 'admin';

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  @override
  List<Object?> get props =>
      [id, displayName, email, avatarUrl, phone, city, country, role, organizerVerified];
}
```
> Note: `/profiles-get` does **not** return email (it lives in `auth.users`). Get email from the existing `GetCurrentUserUseCase` / `CurrentUser` and merge it in the cubit.

### 1.2 Model — `data/models/user_profile_model.dart`
- `fromJson` reads the `profiles` row from `/profiles-get`, including the embedded `organizers` object for `verified`.
- `toEntity({required String email})` — email passed in from `CurrentUser`.
```dart
factory UserProfileModel.fromJson(Map<String, dynamic> json) {
  final org = json['organizers'];
  final orgMap = org is Map<String, dynamic> ? org : null;
  return UserProfileModel(
    id: (json['id'] as String?) ?? '',
    displayName: (json['display_name'] as String?) ?? '',
    avatarUrl: json['avatar_url'] as String?,
    phone: json['phone'] as String?,
    city: json['city'] as String?,
    country: json['country'] as String?,
    role: (json['role'] as String?) ?? 'user',
    organizerVerified: (orgMap?['verified'] as bool?) ?? false,
  );
}
```

### 1.3 Data source — `data/datasources/profile_remote_data_source.dart`
Abstract + `@LazySingleton(as: ProfileRemoteDataSource)` impl with `ApiClient`.
Use the same `_extractList`/unwrap-`data` helper style as `FavoriteRemoteDataSourceImpl`.
```dart
Future<UserProfileModel> getProfile() async {
  final res = await _apiClient.get<dynamic>(ApiEndpoints.profileGet);
  return UserProfileModel.fromJson(_unwrap(res.data));
}

Future<UserProfileModel> updateProfile(Map<String, dynamic> patch) async {
  final res = await _apiClient.post<dynamic>(ApiEndpoints.profile, data: patch);
  return UserProfileModel.fromJson(_unwrap(res.data));
}
```
`_unwrap` returns `body['data']` when present, else `body`, as a `Map<String, dynamic>`
(throw `JsonParsingException` on an unexpected shape — same as favorites).

### 1.4 Repository — `domain/repositories/profile_repository.dart`
```dart
EitherFailure<UserProfile> getProfile();
EitherFailure<UserProfile> updateProfile(UpdateProfileParams params);
```
Impl extends `BaseRepository`, `@LazySingleton(as: ProfileRepository)`, wraps the data
source in `execute(operation: ...)`. For `getProfile`, fetch the model **and** the
current user's email (`GetCurrentUserUseCase` or `AuthSessionService`) and build the
entity with both.

### 1.5 Use cases
- `GetProfileUseCase implements UseCase<UserProfile, NoParams>` — `@lazySingleton`.
- `UpdateProfileUseCase implements UseCase<UserProfile, UpdateProfileParams>`.
  `UpdateProfileParams extends Equatable` with optional `displayName/phone/city/country/avatarUrl`;
  a `toPatch()` method building a `Map<String, dynamic>` that **omits nulls** so a partial
  edit only sends changed fields (matches `/profile-upsert` semantics).

### 1.6 Cubit — `presentation/blocs/profile_cubit.dart`
`@injectable`. State enum `{ idle, loading, loaded, saving, failure }`, holds `UserProfile?`
and `error`. Pattern mirrors `FavoritesListCubit`:
```dart
Future<void> load() async {
  emit(state.copyWith(status: ProfileStatus.loading, error: null));
  final res = await _getProfile(const NoParams());
  res.fold(
    (f) => emit(state.copyWith(status: ProfileStatus.failure,
        error: ErrorHandler.instance.getUserMessage(f))),
    (p) => emit(state.copyWith(status: ProfileStatus.loaded, profile: p)),
  );
}

Future<bool> save(UpdateProfileParams params) async {
  emit(state.copyWith(status: ProfileStatus.saving, error: null));
  final res = await _updateProfile(params);
  return res.fold(
    (f) { emit(state.copyWith(status: ProfileStatus.failure,
        error: ErrorHandler.instance.getUserMessage(f))); return false; },
    (p) { emit(state.copyWith(status: ProfileStatus.loaded, profile: p)); return true; },
  );
}
```

### 1.7 Pages & widgets
- **`profile_page.dart`** (rewrite the placeholder): wrap body in
  `BlocProvider(create: (_) => inject<ProfileCubit>()..load())`, `BlocBuilder`:
  - loading → spinner; failure → retry; loaded →
    - `ProfileHeader(profile)` — avatar (`avatarUrl` → `Image.network`, else initials circle),
      display name, email, a role/verified chip when `profile.isOrganizer`, "Edit profile"
      button → `context.router.push(const EditProfileRoute())`.
    - `ProfileSection` groups of `ProfileMenuTile`:
      - **Activity:** My Tickets → `TicketsRoute()`, Favorites → `FavoriteRoute()` (P1 can route; data already exists)
      - **Settings** → `SettingsRoute()` (built in P3; stub the route now or gate until P3)
      - **About** → `AboutRoute()` (P4)
    - Keep the existing **Sign out** button (calls `LogoutUseCase`).
- **`edit_profile_page.dart`** (`@RoutePage()`): form with `displayName`, `phone`, `city`,
  `country` (prefill from the cubit's current `UserProfile`). Save calls
  `context.read<ProfileCubit>().save(params)`; on `true`, `context.router.maybePop()`.
  - **Avatar upload is deferred** — `image_picker` gives a local file but `avatar_url`
    needs a hosted URL (Supabase Storage). For P1 show initials only; add upload later.

### 1.8 Wiring & verify
- Add the 4 endpoint constants (top of this doc).
- Add `EditProfileRoute` to the router.
- `dart run build_runner build --delete-conflicting-outputs`.
- **Test:** open Profile tab → real name/email/city load; edit name → save → header updates;
  sign out still works.

---

## Phase 2 — Activity (order history)

### 2.1 Entity — `order_summary.dart`
Fields: `id`, `status`, `totalPaisa`, `currency`, `createdAt`, `paidAt?`,
`eventTitle`, `eventId`, `heroImageUrl?`, `items` (list of `{tierName, quantity, linePaisa}`).
Add a `String get totalNpr => (totalPaisa / 100).toStringAsFixed(0)` helper (paisa → NPR;
see [[project-nepal-context]]).

### 2.2 Model — `order_summary_model.dart`
`fromJson` reads the `/orders-mine` row: top-level order fields, nested `events { title,
hero_image_url, id }`, and `order_items[] { quantity, line_paisa, ticket_tiers { name } }`.

### 2.3 Data source / repo / use case
- Add `Future<List<OrderSummaryModel>> listOrders()` to the data source (GET
  `ApiEndpoints.ordersMine`, reuse the `_extractList` helper).
- Repo: `EitherFailure<List<OrderSummary>> getMyOrders();`
- `GetMyOrdersUseCase implements UseCase<List<OrderSummary>, NoParams>`.

### 2.4 Cubit + page
- `order_history_cubit.dart` — same load/fold pattern as `FavoritesListCubit`
  (status enum, list, pull-to-refresh).
- `order_history_page.dart` — list of order cards (event title, date, total NPR,
  status chip). Empty state when no orders. Tapping an order can deep-link to the
  event (`EventDetailRoute(eventId: ...)`) or a future order-detail screen.

### 2.5 Menu links
- In `profile_page.dart` add an **Order history** tile → `OrderHistoryRoute()`.
- My Tickets / Favorites tiles already route to the existing tabs/screens.

### 2.6 Verify
Buy/seed an order (we already seeded one for the test user) → it appears in Order history
with correct NPR total and status.

---

## Phase 3 — Settings

A `SettingsCubit` backed by `StorageService` (shared_preferences) for local prefs, plus
server calls for the notifications toggle.

### 3.1 `settings_cubit.dart`
State holds: `notificationsEnabled` (bool), `locale` ('en' | 'ne'), `themeMode`
(`ThemeMode`). On init, read persisted values from `StorageService`.

### 3.2 Notifications toggle (server + local)
- Keep a local pref `notifications_enabled`.
- **ON:** re-run the existing token registration path (the same call
  `NotificationService` makes to `ApiEndpoints.registerDevice`). Simplest: expose a public
  `NotificationService.registerToken()` and call it.
- **OFF:** POST `ApiEndpoints.unregisterDevice` (body `{}` or `{fcm_token}`), then set the
  local pref. This deletes the device token rows so `push-broadcast` finds nothing.
- Use a `SetNotificationsUseCase` wrapping a repo method `setNotifications(bool enabled)`.

### 3.3 Language (NP / EN)
- App already has `flutter_localizations` + `intl` + `generate: true`.
- `SettingsCubit` exposes `locale`; the root `MaterialApp.router` reads it
  (`locale:` + `supportedLocales:`). This means a small change at the **app root** to
  rebuild on locale change (wrap `MaterialApp` in a `BlocBuilder<SettingsCubit, …>` or
  read from a global provider). Persist choice in `StorageService`.
- Per [[project-nepal-context]], UI copy stays English by default; Nepali is opt-in.

### 3.4 Theme (light/dark) — optional
- `SettingsCubit.themeMode`; root `MaterialApp.themeMode` reads it. Persist in storage.

### 3.5 Location (change saved city)
- Reuse the existing location feature / `ChooseLocationRoute` flow, then persist via
  `/profile-upsert` (`city`, `country`). On success, refresh `ProfileCubit`.

### 3.6 `settings_page.dart`
Switch tiles for notifications + theme, a selector for language, a row for location.
Wrap in `BlocProvider(create: (_) => inject<SettingsCubit>())`.

### 3.7 Verify
Toggle notifications OFF → `device_tokens` row removed (broadcast → `sent:0`); ON →
row re-created. Switch language → visible strings change. Theme persists across restart.

---

## Phase 4 — Support + danger zone

### 4.1 About / legal — `about_page.dart`
- App version via `AppConstants.fullVersion`.
- Links: Help / Contact, Terms, Privacy Policy (open via `url_launcher` or in-app webview;
  `flutter_inappwebview` is already a dependency). Static URLs for now.

### 4.2 Delete account — `account-delete`
- `DeleteAccountUseCase implements UseCase<Unit, NoParams>` → repo `deleteAccount()` →
  data source POST `ApiEndpoints.accountDelete`.
- **UI flow (danger zone in `settings_page.dart` or `profile_page.dart`):**
  1. Red "Delete account" tile.
  2. Confirm dialog explaining it is **permanent** — the account is anonymized and the
     login is disabled; past tickets/orders are retained.
  3. On confirm → call use case → on success, immediately run `LogoutUseCase`
     (clears local session; `SessionListener` swaps to the login route).
- Backend behavior (already deployed): scrubs PII on `profiles`, deletes `device_tokens`
  + `event_favorites`, bans the auth login. See [[project-profile-feature]].

### 4.3 Verify
On a throwaway account: confirm → app returns to login; re-login is rejected (banned);
profile row shows "Deleted user" with nulled PII.

---

## Cross-cutting notes

- **DI:** every new `@injectable`/`@lazySingleton`/`@LazySingleton(as:)` class requires a
  `build_runner` run. Do it once at the end of each phase.
- **Errors:** always surface via `ErrorHandler.instance.getUserMessage(failure)` — never
  raw exceptions in the UI.
- **Comments:** plain simple English, no jargon (see [[feedback-comment-style]]).
- **Reuse, don't recreate:** `BaseRepository`, `EitherFailure`, `UseCase`/`NoParams`,
  `AppColors`, `AppTextStyles`, `CurrentUser`/`GetCurrentUserUseCase`, `LogoutUseCase`,
  existing routes.
- **Deferred:** avatar image upload (needs Supabase Storage), organizer area, order-detail
  screen, real Terms/Privacy content.

## Build order checklist
- [ ] Endpoint constants (4) added
- [ ] Phase 1: entity/model/datasource/repo/usecases/cubit/header/menu/edit + route + build_runner
- [ ] Phase 2: order entity/model + datasource/repo/usecase + cubit + page + menu link
- [ ] Phase 3: SettingsCubit + notifications toggle + language + theme + location + page
- [ ] Phase 4: about/legal page + delete-account use case + confirm flow
