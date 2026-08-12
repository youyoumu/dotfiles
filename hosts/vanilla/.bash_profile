#!/bin/env bash

# Only initialize keychain if SSH Agent Forwarding isn't actively providing a socket
if [ -z "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
  eval "$(keychain --eval --quiet --noask)"
fi

echo "Current SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
