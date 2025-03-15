#!/bin/bash

# File to store toggle state
STATE_FILE="$HOME/.config/hypr/workspace_toggle_state"

# Initialize the file if it doesn't exist (default to normal mode)
if [ ! -f "$STATE_FILE" ]; then
  echo "normal" >"$STATE_FILE"
fi

# Read current state
CURRENT_STATE=$(cat "$STATE_FILE")

# Toggle state
if [ "$CURRENT_STATE" = "normal" ]; then
  echo "alternate" >"$STATE_FILE"
  # notify-send "Workspace Mode" "Switched to alternate workspaces"
else
  echo "normal" >"$STATE_FILE"
  # notify-send "Workspace Mode" "Switched to normal workspaces"
fi
