#!/bin/bash

# source: https://gist.github.com/kbravh/1117a974f89cc53664e55823a55ac320

# Check which sound server is running
if pgrep pulseaudio >/dev/null; then
  sound_server="pulseaudio"
elif pgrep pipewire >/dev/null; then
  sound_server="pipewire"
else
  echo "Neither PulseAudio nor PipeWire is running."
  exit 1
fi

# Grab a count of how many audio sinks we have
if [[ "$sound_server" == "pulseaudio" ]]; then
  sink_count=$(pacmd list-sinks | grep -c "index:[[:space:]][[:digit:]]")
  # Create an array of the actual sink IDs
  sinks=()
  mapfile -t sinks < <(pacmd list-sinks | grep 'index:[[:space:]][[:digit:]]' | sed -n -e 's/.*index:[[:space:]]\([[:digit:]]\)/\1/p')
  # Get the ID of the active sink
  active_sink=$(pacmd list-sinks | sed -n -e 's/[[:space:]]*\*[[:space:]]index:[[:space:]]\([[:digit:]]\)/\1/p')

elif [[ "$sound_server" == "pipewire" ]]; then
  sink_count=$(pactl list sinks | grep -c "Sink #[[:digit:]]")
  # Create an array of the actual sink IDs
  sinks=()
  mapfile -t sinks < <(pactl list sinks | grep 'Sink #[[:digit:]]' | sed -n -e 's/.*Sink #\([[:digit:]]\)/\1/p')
  # Get the ID of the active sink
  active_sink_name=$(pactl info | grep 'Default Sink:' | sed -n -e 's/.*Default Sink:[[:space:]]\+\(.*\)/\1/p')
  active_sink=$(pactl list sinks | grep -B 2 "$active_sink_name" | sed -n -e 's/Sink #\([[:digit:]]\)/\1/p' | head -n 1)
fi

# Find the index of the active sink
for index in "${!sinks[@]}"; do
  if [[ "${sinks[$index]}" == "$active_sink" ]]; then
    active_sink_index=$index
  fi
done

# Create a list of the sink descriptions
sink_descriptions=()
if [[ "$sound_server" == "pulseaudio" ]]; then
  mapfile -t sink_descriptions < <(pacmd list-sinks | sed -n -e 's/.*alsa.name[[:space:]]=[[:space:]]"\(.*\)"/\1/p')
elif [[ "$sound_server" == "pipewire" ]]; then
  mapfile -t sink_descriptions < <(pactl list sinks | sed -n -e 's/.*Description:[[:space:]]\+\(.*\)/\1/p')
fi

# Find the index that matches our new active sink
for sink_index in "${!sink_descriptions[@]}"; do
  if [[ "$sink_index" == "$active_sink_index" ]]; then
    if [[ "${sink_descriptions[$sink_index]}" == "Starship/Matisse HD Audio Controller Digital Stereo (IEC958)" ]]; then
      echo "󰓃 Samsung Soundbar"
    else
      echo "󰓃 ${sink_descriptions[$sink_index]}"
    fi
    exit
  fi
done
