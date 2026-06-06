#!/usr/bin/env bash
#
# set_app_identity.sh
# Update the display name and app icon for this Flutter project across
# Android, iOS, and web in one go.
#
# Usage:
#   scripts/set_app_identity.sh --name "My App" --icon assets/images/app_icon.png
#   scripts/set_app_identity.sh -n "My App"          # name only
#   scripts/set_app_identity.sh -i path/to/icon.png  # icon only
#
# Notes:
#   - The icon should be a square PNG, ideally 1024x1024.
#   - The name may contain spaces; always quote it.
#   - Run from the project root (or anywhere — the script finds the root itself).

set -euo pipefail

# ---------------------------------------------------------------------------
# Locate the project root (the folder that holds pubspec.yaml).
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ ! -f "$ROOT/pubspec.yaml" ]]; then
  echo "error: could not find pubspec.yaml at $ROOT" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# Parse arguments.
# ---------------------------------------------------------------------------
APP_NAME=""
ICON_PATH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--name) APP_NAME="${2:-}"; shift 2 ;;
    -i|--icon) ICON_PATH="${2:-}"; shift 2 ;;
    -h|--help)
      grep '^#' "$0" | cut -c3-
      exit 0 ;;
    *) echo "error: unknown argument '$1'" >&2; exit 1 ;;
  esac
done

if [[ -z "$APP_NAME" && -z "$ICON_PATH" ]]; then
  echo "error: nothing to do — pass --name and/or --icon (see --help)" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# Update the display name on each platform.
# ---------------------------------------------------------------------------
if [[ -n "$APP_NAME" ]]; then
  echo ">> setting display name to: $APP_NAME"

  # Android: the manifest reads android:label="@string/app_name", and the name
  # is supplied per flavor by build.gradle.kts. We treat $APP_NAME as the base
  # name and keep the environments distinguishable on the home screen:
  #   production  -> "Evnto"
  #   development -> "Evnto Dev"
  #   staging     -> "Evnto Staging"
  # Each resValue is edited inside its own flavor block so the suffixes stay put.
  # Run scripts/gen_flavor_icons.sh for per-flavor icons.
  ANDROID_GRADLE="$ROOT/android/app/build.gradle.kts"
  if [[ -f "$ANDROID_GRADLE" ]]; then
    set_flavor_name() {
      # $1 = flavor block name, $2 = full app name for that flavor.
      sed -i "/create(\"$1\")/,/}/ s|\(resValue(\"string\", \"app_name\", \"\)[^\"]*\(\")\)|\1$2\2|" "$ANDROID_GRADLE"
    }
    set_flavor_name "production"  "$APP_NAME"
    set_flavor_name "development" "$APP_NAME Dev"
    set_flavor_name "staging"     "$APP_NAME Staging"
    echo "   android: build.gradle.kts (app_name for all flavors)"
  fi

  # iOS: CFBundleDisplayName is the <string> on the line after the key.
  IOS_PLIST="$ROOT/ios/Runner/Info.plist"
  if [[ -f "$IOS_PLIST" ]]; then
    sed -i "\|<key>CFBundleDisplayName</key>|{n;s|<string>.*</string>|<string>$APP_NAME</string>|;}" "$IOS_PLIST"
    echo "   ios: Info.plist (CFBundleDisplayName)"
  fi

  # Web: manifest name/short_name and the page title.
  WEB_MANIFEST="$ROOT/web/manifest.json"
  if [[ -f "$WEB_MANIFEST" ]]; then
    sed -i "s|\"name\": \"[^\"]*\"|\"name\": \"$APP_NAME\"|" "$WEB_MANIFEST"
    sed -i "s|\"short_name\": \"[^\"]*\"|\"short_name\": \"$APP_NAME\"|" "$WEB_MANIFEST"
    echo "   web: manifest.json"
  fi
  WEB_INDEX="$ROOT/web/index.html"
  if [[ -f "$WEB_INDEX" ]]; then
    sed -i "s|<title>.*</title>|<title>$APP_NAME</title>|" "$WEB_INDEX"
    echo "   web: index.html (<title>)"
  fi
fi

# ---------------------------------------------------------------------------
# Update the app icon via flutter_launcher_icons.
# ---------------------------------------------------------------------------
if [[ -n "$ICON_PATH" ]]; then
  # Resolve a relative icon path against the project root.
  if [[ "$ICON_PATH" != /* && ! -f "$ICON_PATH" ]]; then
    ICON_PATH="$ROOT/$ICON_PATH"
  fi
  if [[ ! -f "$ICON_PATH" ]]; then
    echo "error: icon file not found: $ICON_PATH" >&2
    exit 1
  fi

  # Path relative to root — flutter_launcher_icons expects a project-relative path.
  REL_ICON="${ICON_PATH#$ROOT/}"
  echo ">> generating launcher icons from: $REL_ICON"

  # Write a standalone config so pubspec.yaml stays untouched.
  CONFIG="$ROOT/flutter_launcher_icons.yaml"
  cat > "$CONFIG" <<EOF
flutter_launcher_icons:
  image_path: "$REL_ICON"
  android: true
  ios: true
  remove_alpha_ios: true
  web:
    generate: true
  windows:
    generate: true
  macos:
    generate: true
EOF

  ( cd "$ROOT" && flutter pub get && dart run flutter_launcher_icons -f flutter_launcher_icons.yaml )
  echo "   icons generated for android, ios, web, windows, macos"
fi

echo ">> done. Rebuild the app to see the changes."
