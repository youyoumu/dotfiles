#!/usr/bin/env bash

sleep 1
kitty &
microsoft-edge --disable-features=GlobalShortcutsPortal &
discord --ozone-playform-hint=auto --enable-wayland-ime --wayland-text-input-version=3 &
antimicrox --hidden &
sleep 10
anki
