#!/usr/bin/env bash

sleep 5
ghostty +new-window &

sleep 5
microsoft-edge --disable-features=GlobalShortcutsPortal &

sleep 5
discord --ozone-playform-hint=auto --enable-wayland-ime --wayland-text-input-version=3 &
antimicrox --hidden &

sleep 10
anki
