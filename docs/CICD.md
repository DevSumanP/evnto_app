# CI/CD

How the Evnto Android app is validated and shipped. Two GitHub Actions
workflows drive everything:

- **`.github/workflows/pr_validation.yml`** — runs on every pull request into
  `dev`, `staging`, or `main`. Formats, generates code, and analyzes. No deploy.
- **`.github/workflows/deploy.yml`** — runs on every push to `dev`, `staging`,
  or `main` (i.e. after a merge). Builds and uploads to the right destination.

## Branch model

Three long-lived branches. Changes promote upward through PRs:

```
feature/* -> dev -> staging -> main
```

Each branch maps to one build flavor and one destination:

| Branch  | Flavor        | applicationId       | Artifact | Destination                          |
| ------- | ------------- | ------------------- | -------- | ------------------------------------ |
| dev     | development   | `com.evnto.app.dev` | APK      | Firebase App Distribution            |
| staging | staging       | `com.evnto.app`     | AAB      | Play Console — internal testing      |
| main    | production    | `com.evnto.app`     | AAB      | Play Console — production (10% roll) |

Notes:
- `staging` and `production` share `com.evnto.app`. They cannot be installed on
  one device at the same time; they reach testers through different Play tracks.
- `applicationId` is permanent once the app is on Play. Do not change it.
- The Dart package name stays `tap_app`; only the Android applicationId changed.

## Deploy flow

`deploy.yml` runs these steps in order:

1. Checkout.
2. Resolve the flavor, entrypoint, build artifact, and Fastlane lane from the
   branch name.
3. Set up Java 17 and Flutter.
4. `flutter pub get`.
5. `dart run build_runner build` (regenerates freezed/injectable/auto_route).
6. **Materialize secrets** — `scripts/ci_materialize_secrets.sh <flavor>`.
7. `flutter build <apk|appbundle> --release --flavor <flavor> --build-number=<run>`.
8. Set up Ruby and Fastlane.
9. Run the matching Fastlane lane to upload.

`versionCode` comes from the GitHub run number, so it always increases.
`versionName` comes from `pubspec.yaml`.

## How secrets work

Secrets are stored in **GitHub Secrets** as strings. The build tools, however,
read **files** (`.env`, `google-services.json`, the keystore, service account
JSON). `scripts/ci_materialize_secrets.sh` is the bridge: it takes the secret
values (passed in as environment variables) and writes them to the file paths
the tools expect, just before the build. The real files are gitignored; the
repo only commits empty placeholders so asset bundling never breaks locally.

The script also runs in PR validation, where the `.env` files are instead seeded
from `.env.example` (no real secrets needed just to analyze).

## GitHub Secrets

Set these in **Settings → Secrets and variables → Actions**.

| Secret                          | Used by              | What it is                                              |
| ------------------------------- | -------------------- | ------------------------------------------------------- |
| `ENV_DEVELOPMENT`               | build                | Full contents of `.env.development`                     |
| `ENV_STAGING`                   | build                | Full contents of `.env.staging`                         |
| `ENV_PRODUCTION`                | build                | Full contents of `.env.production`                      |
| `GOOGLE_SERVICES`               | build                | base64 of `google-services.json` (one Firebase project) |
| `ANDROID_KEYSTORE_BASE64`       | build (signing)      | base64 of the upload keystore (`.jks`)                  |
| `ANDROID_KEYSTORE_PASSWORD`     | build (signing)      | Keystore store password                                 |
| `ANDROID_KEY_ALIAS`             | build (signing)      | Key alias                                               |
| `ANDROID_KEY_PASSWORD`          | build (signing)      | Key password                                            |
| `MAPS_API_KEY`                  | build                | Google Maps Android API key                             |
| `PLAY_SERVICE_ACCOUNT_JSON`     | Fastlane (staging/prod) | Play Console API service account JSON                |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Fastlane (dev)       | Firebase service account JSON                           |
| `FIREBASE_APP_ID_DEV`           | Fastlane (dev)       | Firebase Android App ID for `com.evnto.app.dev`         |

Optional variable (**Variables** tab, not Secrets):

| Variable                 | Default            | What it is                              |
| ------------------------ | ------------------ | --------------------------------------- |
| `FIREBASE_TESTER_GROUPS` | `internal-testers` | Comma-separated App Distribution groups |

## One-time manual setup

The workflows will run before this is done, but the deploy step fails at upload
until all of it exists.

### Upload keystore
1. Generate: `keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
2. base64-encode it and store as `ANDROID_KEYSTORE_BASE64`; store the passwords
   and alias in the matching secrets.
3. Keep the keystore safe and offline. Losing it means you cannot update the app.

### Play Console
1. Create the app for `com.evnto.app`.
2. **Upload the first AAB manually** through the UI. The API rejects uploads
   until at least one release exists.
3. Set up the internal testing and production tracks.
4. Create a Google Cloud service account, grant it access under
   **Play Console → Setup → API access**, download its JSON → `PLAY_SERVICE_ACCOUNT_JSON`.

### Firebase (project `evnto-6afcd`)
1. Confirm the `com.evnto.app.dev` Android app exists; copy its **App ID** →
   `FIREBASE_APP_ID_DEV`.
2. Create a service account with the **Firebase App Distribution Admin** role,
   download its JSON → `FIREBASE_SERVICE_ACCOUNT_JSON`.
3. Create the `internal-testers` tester group.

### Maps API key
Restrict the key to the `com.evnto.app`, `com.evnto.app.dev` package names plus
the Play app-signing SHA-1.

## Branch protection

Enforced branch protection (require the `Analyze & Test` check, require PRs) is
**not enabled** — GitHub only allows it on public repos or private repos with
GitHub Pro. The repo is currently private + free, so PR validation runs and
reports status but does not block merges. To enable later (after upgrading to
Pro or going public), require the `Analyze & Test` status check on all three
branches. The owner is solo, so set required approvals to 0 (you cannot approve
your own PR).

## Local development

These files are gitignored; create them locally from the committed templates:

- `.env.development` (and `.staging` / `.production`) — copy from `.env.example`.
- `android/key.properties` — copy from `android/key.properties.example`, point
  `storeFile` at your local keystore. Without it, release builds fall back to
  debug signing so `flutter run --release` still works.
- `android/secrets.properties` — `MAPS_API_KEY=<your key>`.

Run a flavor locally:

```
flutter run --flavor development -t lib/main_development.dart
```
