#!/bin/bash

# Set the output directory
OUTPUT_DIR="$HOME/Videos/Screencasts"
mkdir -p "$OUTPUT_DIR"

# Generate a filename with timestamp
FILENAME="recording_$(date '+%Y-%m-%d_%H-%M-%S').mp4"
FILEPATH="$OUTPUT_DIR/$FILENAME"

# Show a selection border using grim before slurp
REGION=$(slurp -b 00000055) # 55 is transparency (00-FF)

# If a region was selected, start recording
if [ -n "$REGION" ]; then
  echo "Recording started... Press Ctrl+C to stop."
  wf-recorder -g "$REGION" -f "$FILEPATH"
  echo "Recording saved as $FILEPATH"
else
  echo "No region selected. Exiting."
fi
