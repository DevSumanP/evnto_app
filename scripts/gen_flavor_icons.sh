#!/usr/bin/env bash
#
# gen_flavor_icons.sh
# Generate a different launcher icon per build flavor (development, staging,
# production) using flutter_launcher_icons.
#
# How it works:
#   flutter_launcher_icons auto-detects any config file named
#   "flutter_launcher_icons-<flavor>.yaml" and writes each flavor's icons into
#   that flavor's own resource folder (android/app/src/<flavor>/res/...).
#   This script writes those three config files from your source images, then
#   runs the generator once.
#
# Source images (square PNG, ideally 1024x1024). Defaults shown; override any
# with a flag:
#   development -> assets/icons/icon_dev.png      ( --dev  <path> )
#   staging     -> assets/icons/icon_staging.png  ( --stg  <path> )
#   production  -> assets/icons/icon_prod.png     ( --prod <path> )
#
# Usage:
#   scripts/gen_flavor_icons.sh
#   scripts/gen_flavor_icons.sh --dev assets/icons/dev.png --prod assets/icons/prod.png
#
# Build with the matching flavor afterwards, e.g.:
#   flutter run --flavor development -t lib/main_development.dart

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ ! -f "$ROOT/pubspec.yaml" ]]; then
  echo "error: could not find pubspec.yaml at $ROOT" >&2
  exit 1
fi

# Default source image per flavor.
DEV_ICON="assets/icons/icon_dev.png"
STG_ICON="assets/icons/icon_staging.png"
PROD_ICON="assets/icons/icon_prod.png"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dev)  DEV_ICON="${2:-}";  shift 2 ;;
    --stg)  STG_ICON="${2:-}";  shift 2 ;;
    --prod) PROD_ICON="${2:-}"; shift 2 ;;
    -h|--help) grep '^#' "$0" | cut -c3-; exit 0 ;;
    *) echo "error: unknown argument '$1'" >&2; exit 1 ;;
  esac
done

# Map flavor name -> source image. Edit these two arrays together if you ever
# add or rename a flavor (they must stay aligned with android/app/build.gradle.kts).
FLAVORS=(development staging production)
ICONS=("$DEV_ICON" "$STG_ICON" "$PROD_ICON")

# Resolve a path against the project root and confirm the file exists.
resolve_icon() {
  local p="$1"
  if [[ "$p" != /* && ! -f "$p" ]]; then
    p="$ROOT/$p"
  fi
  if [[ ! -f "$p" ]]; then
    echo "error: icon file not found: $1" >&2
    echo "       add the file, or pass a path with --dev / --stg / --prod (see --help)" >&2
    exit 1
  fi
  # Return the path relative to root, which is what the config expects.
  echo "${p#$ROOT/}"
}

# Write one config file per flavor.
for i in "${!FLAVORS[@]}"; do
  flavor="${FLAVORS[$i]}"
  rel_icon="$(resolve_icon "${ICONS[$i]}")"
  config="$ROOT/flutter_launcher_icons-$flavor.yaml"
  cat > "$config" <<EOF
flutter_launcher_icons:
  image_path: "$rel_icon"
  android: true
  ios: true
  remove_alpha_ios: true
EOF
  echo ">> $flavor icon: $rel_icon  ->  flutter_launcher_icons-$flavor.yaml"
done

# Generate. With no -f flag, flutter_launcher_icons processes every
# flutter_launcher_icons-<flavor>.yaml it finds.
( cd "$ROOT" && flutter pub get && dart run flutter_launcher_icons )

echo ">> done. Android icons written per flavor under android/app/src/<flavor>/res/."
echo "   Verify with:  flutter run --flavor development -t lib/main_development.dart"
