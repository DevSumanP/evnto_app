# Evnto — Mobile App (`tap_app`)

Flutter client for **Evnto**, an event discovery and ticketing app for Nepal.
Browse and search events, buy tickets (Khalti), hold seats, and check in with
NFC/QR at the venue.

> Backend lives in a separate repo: **`github.com/DevSumanP/evnto_backend`**
> (Supabase edge functions + Postgres). See its `README.md` / `SETUP.md`.

## Stack

| Layer | Choice |
|---|---|
| Framework | Flutter 3.35.x · Dart `^3.9.2` |
| State | `flutter_bloc` 9 · `bloc` |
| DI | `get_it` + `injectable` |
| Routing | `auto_route` |
| Networking | `dio`, `connectivity_plus`, `internet_connection_checker_plus` |
| Models | `freezed` + `json_serializable` |
| Env | `flutter_dotenv` |
| Maps | `google_maps_flutter`, `flutter_map` (OSM), `geolocator` |
| Payments | `flutter_inappwebview` (Khalti KPG-2) |
| NFC / QR | `flutter_nfc_kit`, `ndef`, `nearby_connections`, `mobile_scanner`, `qr_flutter` |
| Notifications | `firebase_core`, `firebase_messaging` (FCM) |
| Analytics | `posthog_flutter` |
| Build / CI | Gradle, Fastlane, GitHub Actions |

Android applicationId: `com.evnto.app` (flavors: `.dev` for development).

## Architecture

Clean architecture, one folder per feature under `lib/feature/` with `data/`,
`domain/`, `presentation/` layers:

```
lib/
  core/        config, constants, di, network, router, services, theme, utils
  feature/     auth, checkout, event-detail, explore, favorite, home,
               location, onboard, profile, shell, splash, tickets
  shared/      shared widgets, utils
  main_development.dart / main_staging.dart / main_production.dart
```

Notable: the **home feed is server-driven (SDUI)** — sections come from the
backend `home-layout` edge function and are rendered by widgets in
`lib/feature/home/presentation/widgets/sdui/` based on the user's segment
(`newcomer` / `regular` / `explorer`).

## Getting started

Prerequisites: Flutter 3.35.x, JDK 17, Android SDK, (optional) `dart` CLI.

```bash
git clone https://github.com/DevSumanP/evnto_app.git
cd evnto_app
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed/injectable/auto_route
```

### Local config (gitignored — create from templates)

| File | Template | Notes |
|---|---|---|
| `.env.development` / `.staging` / `.production` | `.env.example` | API + Supabase URL/anon key, PostHog |
| `android/key.properties` | `android/key.properties.example` | release signing; falls back to debug if absent |
| `android/secrets.properties` | — | `MAPS_API_KEY=<key>` |
| `ios/Flutter/Secrets.xcconfig` | — | iOS Maps key |

`key.properties` values: `storeFile`, `storePassword`, `keyAlias`, `keyPassword`
(see `android/app/build.gradle.kts`; it also accepts `ANDROID_KEYSTORE_*` env vars).

### Run

```bash
flutter run --flavor development -t lib/main_development.dart
flutter run --flavor staging     -t lib/main_staging.dart
```

### Build release

```bash
flutter build appbundle --release --flavor production -t lib/main_production.dart
```

## Branch model & deploy

```
feature/* -> dev -> staging -> main
```

| Branch | Flavor | applicationId | Artifact | Destination |
|---|---|---|---|---|
| `dev` | development | `com.evnto.app.dev` | APK | Firebase App Distribution (`internal-testers`) |
| `staging` | staging | `com.evnto.app` | AAB | Play Console internal testing |
| `main` | production | `com.evnto.app` | AAB | Play Console production (10% rollout) |

- **Deploying needs no local secrets** — pushing/merging to `dev`/`staging`/`main`
  triggers `.github/workflows/deploy.yml`, which rebuilds every config file from
  GitHub Secrets via `scripts/ci_materialize_secrets.sh`.
- `versionCode` = GitHub run number; `versionName` = `pubspec.yaml`.
- PRs run `.github/workflows/pr_validation.yml` (format + codegen + analyze).

Full details, secret list, and one-time Play/Firebase setup: **`docs/CICD.md`**.

## Related docs

- `docs/CICD.md` — CI/CD, secrets, Play/Firebase setup
- `DESIGN.md` — design system
- `PROFILE_FEATURE_PLAN.md` — profile feature plan

## Security

Never commit `.env`, `key.properties`, `upload-keystore.jks`, `secrets.properties`,
`google-services.json`, or service-account JSONs. All are gitignored; the repo
ships only `*.example` templates. Android upload keystore must be kept offline —
losing it blocks future Play updates.
