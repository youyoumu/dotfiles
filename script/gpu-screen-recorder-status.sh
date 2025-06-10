#!/usr/bin/env bash

PID_FILE="./gpu-screen-recoder.pid"

# Function to get recording duration
get_duration() {
  local pid=$1
  if [[ -n "$pid" ]]; then
    # Get process start time in seconds since epoch
    local start_time=$(stat -c %Y /proc/$pid 2>/dev/null)
    if [[ -n "$start_time" ]]; then
      local current_time=$(date +%s)
      local duration=$((current_time - start_time))

      # Format duration as HH:MM:SS
      local hours=$((duration / 3600))
      local minutes=$(((duration % 3600) / 60))
      local seconds=$((duration % 60))

      printf "%02d:%02d:%02d" $hours $minutes $seconds
    fi
  fi
}

# Check if PID file exists and has content
if [[ -f "$PID_FILE" && -s "$PID_FILE" ]]; then
  PID=$(cat "$PID_FILE" 2>/dev/null)

  # Check if process is actually running
  if [[ -n "$PID" ]] && kill -0 "$PID" 2>/dev/null; then
    # Process is running
    DURATION=$(get_duration "$PID")

    # Waybar JSON output for recording state
    echo "{\"text\": \"󰑋 REC $DURATION\", \"tooltip\": \"Recording (PID: $PID)\\nDuration: $DURATION\", \"class\": \"recording\"}"
  else
    # PID file exists but process is not running (stale file)
    echo "{\"text\": \" \", \"tooltip\": \"Stale PID file detected\", \"class\": \"error\"}"
  fi
else
  # Not recording
  echo "{\"text\": \" \", \"tooltip\": \"Not recording. Click to record. Right click to record with audio\", \"class\": \"idle\"}"
fi
