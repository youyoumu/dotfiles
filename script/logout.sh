#!/bin/env bash

# This script provides a simple way to log out from different Wayland desktop environments.
# It checks the XDG_CURRENT_DESKTOP environment variable and executes the appropriate logout command.

# Check if XDG_CURRENT_DESKTOP is set
if [ -z "$XDG_CURRENT_DESKTOP" ]; then
  echo "Error: XDG_CURRENT_DESKTOP environment variable is not set."
  echo "Cannot determine the current desktop environment for logout."
  exit 1
fi

# Convert the desktop environment name to lowercase for case-insensitive comparison
DESKTOP_ENV=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

# Perform logout based on the desktop environment
case "$DESKTOP_ENV" in
hyprland)
  echo "Logging out from Hyprland..."
  hyprctl dispatch exit
  ;;
niri)
  echo "Logging out from Niri..."
  niri msg action quit --skip-confirmation
  ;;
*)
  echo "Warning: Unsupported desktop environment: $XDG_CURRENT_DESKTOP"
  echo "Please add the appropriate logout command for your desktop environment to this script."
  exit 1
  ;;
esac

exit 0
