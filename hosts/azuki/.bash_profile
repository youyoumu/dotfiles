#!/bin/env bash

eval "$(keychain --eval --quiet --noask)"

if command -v fish >/dev/null 2>&1; then
  exec fish -li
fi
