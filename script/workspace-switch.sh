#!/bin/bash

# Ensure an argument was provided
if [ $# -ne 1 ]; then
  echo "Error: Please provide a single workspace number (1-9)"
  exit 1
fi

# Validate input is a number between 1-9
if ! [[ "$1" =~ ^[1-9]$ ]]; then
  echo "Error: Argument must be a single digit between 1-9"
  exit 1
fi

# Get the current monitor name
MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

# Determine the workspace prefix based on the monitor
case "$MONITOR" in
"HDMI-A-1" | "monitor-1")
  PREFIX=0 # For monitor 1: workspaces 1-9
  ;;
"DP-3" | "monitor-2")
  PREFIX=10 # For monitor 2: workspaces 11-19
  ;;
"DP-2" | "monitor-3")
  PREFIX=20 # For monitor 3: workspaces 21-29
  ;;
*)
  # Default case - use the monitorID to determine prefix
  MONITOR_ID=$(hyprctl activeworkspace -j | jq '.monitorID')
  # monitorID is 0-indexed, but we want monitor 1 to have prefix 0
  PREFIX=$((MONITOR_ID * 10))
  ;;
esac

# Calculate the target workspace
TARGET_WORKSPACE=$((PREFIX + $1))

# Switch to the target workspace
hyprctl dispatch workspace $TARGET_WORKSPACE
