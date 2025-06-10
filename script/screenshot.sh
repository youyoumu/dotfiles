#!/bin/env bash

detect_compositor() {
  # Check if we're running under a desktop session (e.g., GNOME, KDE, Cinnamon)
  if [ -n "$DESKTOP_SESSION" ] || pgrep -x "$DESKTOP_SESSION" >/dev/null 2>&1; then
    echo "$DESKTOP_SESSION"
    return
  fi

  # Check if we're running under Niri
  if [ -n "$NIRI_SOCKET" ] || pgrep -x niri >/dev/null 2>&1; then
    echo "niri"
    return
  fi

  # Check if we're running under Hyprland
  if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ] || pgrep -x Hyprland >/dev/null 2>&1; then
    echo "hyprland"
    return
  fi

  # Fallback - try to detect from processes
  if pgrep -f "niri" >/dev/null 2>&1; then
    echo "niri"
  elif pgrep -f "Hyprland" >/dev/null 2>&1; then
    echo "hyprland"
  else
    echo "unknown"
  fi
}

# Main screenshot function
take_screenshot() {
  local mode="$1"
  local compositor=$(detect_compositor)

  case "$compositor" in
  "niri")
    case "$mode" in
    "monitor")
      niri msg action screenshot-screen
      ;;
    "region")
      niri msg action screenshot
      ;;
    "window")
      niri msg action screenshot-window
      ;;
    "region-delay")
      sleep 3
      niri msg action screenshot
      ;;
    *)
      echo "Usage: $0 {monitor|region|window|region-delay}"
      exit 1
      ;;
    esac
    ;;
  "hyprland")
    case "$mode" in
    "monitor")
      hyprshot -m output
      ;;
    "region")
      hyprshot -m region
      ;;
    "window")
      hyprshot -m window
      ;;
    "region-delay")
      sleep 3 && hyprshot -m region --freeze
      ;;
    *)
      echo "Usage: $0 {monitor|region|window|region-delay}"
      exit 1
      ;;
    esac
    ;;
  *)
    echo "Error: Unsupported compositor '$compositor'"
    echo "This script supports Hyprland and Niri only"
    exit 1
    ;;
  esac
}

# Check if mode is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 {monitor|region|window|region-delay}"
  echo "Current compositor: $(detect_compositor)"
  exit 1
fi

# Take screenshot with specified mode
take_screenshot "$1"
