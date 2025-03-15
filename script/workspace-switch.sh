#!/bin/bash
# Ensure arguments were provided
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <workspace_number> [move]"
  echo "  workspace_number: A digit between 1-9"
  echo "  move: Optional. If 'move' is specified, moves the active window to the workspace"
  exit 1
fi

# Validate input is a number between 1-9
if ! [[ "$1" =~ ^[1-9]$ ]]; then
  echo "Error: First argument must be a single digit between 1-9"
  exit 1
fi

# Check the toggle state
STATE_FILE="$HOME/.config/hypr/workspace_toggle_state"
if [ ! -f "$STATE_FILE" ]; then
  echo "normal" >"$STATE_FILE"
fi
TOGGLE_STATE=$(cat "$STATE_FILE")

# Get the current monitor name
MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

# Determine the workspace prefix based on the monitor
case "$MONITOR" in
"HDMI-A-1" | "monitor-1")
  if [ "$TOGGLE_STATE" = "normal" ]; then
    PREFIX=0 # For monitor 1: workspaces 1-9
  else
    PREFIX=40 # For monitor 1 alternate: workspaces 41-49
  fi
  ;;
"DP-3" | "monitor-2")
  if [ "$TOGGLE_STATE" = "normal" ]; then
    PREFIX=10 # For monitor 2: workspaces 11-19
  else
    PREFIX=50 # For monitor 2 alternate: workspaces 51-59
  fi
  ;;
"DP-2" | "monitor-3")
  if [ "$TOGGLE_STATE" = "normal" ]; then
    PREFIX=20 # For monitor 3: workspaces 21-29
  else
    PREFIX=60 # For monitor 3 alternate: workspaces 61-69
  fi
  ;;
*)
  # Default case - use the monitorID to determine prefix
  MONITOR_ID=$(hyprctl activeworkspace -j | jq '.monitorID')
  # monitorID is 0-indexed, but we want monitor 1 to have prefix 0
  if [ "$TOGGLE_STATE" = "normal" ]; then
    PREFIX=$((MONITOR_ID * 10))
  else
    PREFIX=$(((MONITOR_ID * 10) + 40))
  fi
  ;;
esac

# Calculate the target workspace
TARGET_WORKSPACE=$((PREFIX + $1))

# Determine whether to switch to workspace or move window to workspace
if [ "$2" = "move" ]; then
  # Move the active window to the target workspace
  hyprctl dispatch movetoworkspace $TARGET_WORKSPACE
else
  # Switch to the target workspace
  hyprctl dispatch workspace $TARGET_WORKSPACE
fi
