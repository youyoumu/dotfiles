#!/usr/bin/env bash
set -e
AUDIO="off"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  --audio)
    AUDIO="on"
    shift
    ;;
  *)
    echo "Unknown argument: $1"
    exit 1
    ;;
  esac
done

PID_FILE="./gpu-screen-recoder.pid"

# Check if recorder is already running
if [[ -f "$PID_FILE" && -s "$PID_FILE" ]]; then
  PID=$(cat "$PID_FILE")
  if kill -0 "$PID" 2>/dev/null; then
    echo "Stopping existing recorder with PID: $PID"
    kill "$PID"
    rm -f "$PID_FILE"

    # Send notification
    if command -v notify-send >/dev/null 2>&1; then
      notify-send "GPU Screen Recorder" "Recording stopped" -t 3000
    else
      echo "Recording stopped"
    fi
    exit 0
  else
    # PID file exists but process is not running, clean up
    rm -f "$PID_FILE"
  fi
fi

# Timestamped filename
OUTPUT_DIR="$HOME/Videos/gpu-screen-recorder"
mkdir -p "$OUTPUT_DIR"
FILENAME="$OUTPUT_DIR/$(date +'%Y-%m-%d_%H-%M-%S').mp4"

# Build command
CMD=(gpu-screen-recorder -o "$FILENAME")

# Add audio if requested
if [[ "$AUDIO" == "on" ]]; then
  CMD+=(-a default_output)
fi

# Get region selection
REGION=$(slurp -o -f "%wx%h+%x+%y")
if [[ -z "$REGION" ]]; then
  echo "No region selected. Exiting."
  exit 1
fi

CMD+=(-w region -region "$REGION")

# Save current PID (before exec replaces the process)
echo $$ >"$PID_FILE"
echo "Starting gpu-screen-recorder with PID: $$"

# Run the command
exec "${CMD[@]}"
