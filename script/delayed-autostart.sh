#!/usr/bin/env bash

sleep 5
anki &
discord --ozone-playform-hint=auto --enable-wayland-ime --wayland-text-input-version=3 &
antimicro --hidden &
