#!/usr/bin/env bash
set -euo pipefail

# Output path
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
mkdir -p "$WALLPAPER_DIR"

OUT="$WALLPAPER_DIR/current.png"

# Bing API (en-US, you can change "en-US" to another locale)
URL_JSON="https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"

# Get image URL
IMG_URL=$(curl -s "$URL_JSON" | jq -r '.images[0].url')

# Prepend Bing host
FULL_URL="https://www.bing.com${IMG_URL}"

# Download image
curl -s -L "$FULL_URL" -o "$OUT"
