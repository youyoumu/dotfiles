#!/bin/env bash

# Check if fcitx5 is running
if pgrep "fcitx5" >/dev/null; then
  echo "Killing fcitx5..."
  pkill fcitx5
else
  echo "Starting fcitx5..."
  fcitx5 &
fi
