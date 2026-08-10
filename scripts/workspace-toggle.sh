#!/usr/bin/env bash

# File to store toggle state
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/workspace-toggle-state"

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
