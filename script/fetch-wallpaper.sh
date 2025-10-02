#!/usr/bin/env bash
set -euo pipefail

# Output path
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
mkdir -p "$WALLPAPER_DIR"

OUT="$WALLPAPER_DIR/peapix-wallpaper.jpg"

# Peapix API
URL_JSON="https://peapix.com/spotlight/feed"

# Get the first image URL (highest resolution is "fullUrl")
IMG_URL=$(curl -s "$URL_JSON" | jq -r '.[0].fullUrl')

# Download image
curl -s -L "$IMG_URL" -o "$OUT"
