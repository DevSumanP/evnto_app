#!/usr/bin/env bash
#
# ci_materialize_secrets.sh <flavor>
#
# Writes the gitignored config files that the build needs, using values passed
# in as environment variables (GitHub Secrets). Run this in CI before the build.
# The repo only commits empty placeholders so asset bundling never breaks; this
# script overwrites them with the real values for the chosen flavor.
#
# flavor: development | staging | production
#
# Files written:
#   .env.<flavor>                                  (Dart env, from ENV_<FLAVOR>)
#   android/app/src/<flavor>/google-services.json  (from GOOGLE_SERVICES, base64)
#   android/key.properties + upload keystore       (from ANDROID_KEYSTORE_*)
#   android/secrets.properties                     (MAPS_API_KEY)
#   android/fastlane-play-service-account.json     (PLAY_SERVICE_ACCOUNT_JSON)
#   android/firebase-service-account.json          (FIREBASE_SERVICE_ACCOUNT_JSON)
#
# Secrets are only required for the lanes that use them: dev needs Firebase,
# staging/production need Play. Missing optional secrets are skipped with a note.

set -euo pipefail

FLAVOR="${1:-}"
case "$FLAVOR" in
  development|staging|production) ;;
  *)
    echo "usage: $0 <development|staging|production>" >&2
    exit 1
    ;;
esac

# Resolve repo root from this script's location so it works from any CWD.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT"

# Uppercased flavor for the ENV_<FLAVOR> secret name (ENV_DEVELOPMENT, etc.).
FLAVOR_UPPER="$(echo "$FLAVOR" | tr '[:lower:]' '[:upper:]')"

note()  { echo "  - $*"; }
fail()  { echo "ERROR: $*" >&2; exit 1; }

# Pick base64 -d on Linux/macOS or --decode where -d is unavailable.
b64_decode() {
  if base64 --help 2>&1 | grep -q -- "-d"; then base64 -d; else base64 --decode; fi
}

echo "Materializing secrets for flavor: $FLAVOR"

# ── 1. Dart .env file ────────────────────────────────────────────────────────
# ENV_<FLAVOR> holds the full .env contents (multiline secret, not base64).
ENV_VAR="ENV_${FLAVOR_UPPER}"
if [ -n "${!ENV_VAR:-}" ]; then
  printf '%s\n' "${!ENV_VAR}" > ".env.${FLAVOR}"
  note "wrote .env.${FLAVOR}"
else
  fail "$ENV_VAR is not set — the app cannot build without its .env"
fi

# ── 2. google-services.json (one Firebase project, same file all flavors) ─────
if [ -n "${GOOGLE_SERVICES:-}" ]; then
  dest="android/app/src/${FLAVOR}/google-services.json"
  mkdir -p "$(dirname "$dest")"
  printf '%s' "$GOOGLE_SERVICES" | b64_decode > "$dest"
  note "wrote $dest"
else
  fail "GOOGLE_SERVICES (base64 google-services.json) is not set"
fi

# ── 3. Upload keystore + key.properties (release signing) ─────────────────────
# storeFile in key.properties is resolved relative to android/app/, so place the
# keystore there and reference it by bare filename.
if [ -n "${ANDROID_KEYSTORE_BASE64:-}" ]; then
  : "${ANDROID_KEYSTORE_PASSWORD:?ANDROID_KEYSTORE_PASSWORD required with keystore}"
  : "${ANDROID_KEY_ALIAS:?ANDROID_KEY_ALIAS required with keystore}"
  : "${ANDROID_KEY_PASSWORD:?ANDROID_KEY_PASSWORD required with keystore}"

  printf '%s' "$ANDROID_KEYSTORE_BASE64" | b64_decode > "android/app/upload-keystore.jks"
  cat > "android/key.properties" <<EOF
storeFile=upload-keystore.jks
storePassword=${ANDROID_KEYSTORE_PASSWORD}
keyAlias=${ANDROID_KEY_ALIAS}
keyPassword=${ANDROID_KEY_PASSWORD}
EOF
  note "wrote android/app/upload-keystore.jks + android/key.properties"
else
  note "ANDROID_KEYSTORE_BASE64 unset — release build will fall back to debug signing"
fi

# ── 4. Google Maps key ────────────────────────────────────────────────────────
if [ -n "${MAPS_API_KEY:-}" ]; then
  cat > "android/secrets.properties" <<EOF
MAPS_API_KEY=${MAPS_API_KEY}
EOF
  note "wrote android/secrets.properties"
else
  note "MAPS_API_KEY unset — maps will be disabled in this build"
fi

# ── 5. Play Console service account (Fastlane supply: staging/production) ──────
if [ -n "${PLAY_SERVICE_ACCOUNT_JSON:-}" ]; then
  printf '%s' "$PLAY_SERVICE_ACCOUNT_JSON" > "android/fastlane-play-service-account.json"
  note "wrote android/fastlane-play-service-account.json"
elif [ "$FLAVOR" != "development" ]; then
  note "PLAY_SERVICE_ACCOUNT_JSON unset — Play upload lane will fail if invoked"
fi

# ── 6. Firebase service account (App Distribution: development) ────────────────
if [ -n "${FIREBASE_SERVICE_ACCOUNT_JSON:-}" ]; then
  printf '%s' "$FIREBASE_SERVICE_ACCOUNT_JSON" > "android/firebase-service-account.json"
  note "wrote android/firebase-service-account.json"
elif [ "$FLAVOR" = "development" ]; then
  note "FIREBASE_SERVICE_ACCOUNT_JSON unset — App Distribution lane will fail if invoked"
fi

echo "Done."
