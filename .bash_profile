#!/bin/env bash

if [ -r "$HOME/.private.sh" ]; then . "$HOME/.private.sh"; fi

# --- Import environment.d/session.conf ---
if [ -r "$HOME/scripts/import-session-conf.sh" ]; then
    source "$HOME/scripts/import-session-conf.sh"
    import_session_conf
    unset -f import_session_conf
fi

case "$(hostname)" in
chocola) source "$HOME/hosts/chocola/.bash_profile" ;;
vanilla) source "$HOME/hosts/vanilla/.bash_profile" ;;
coconut) source "$HOME/hosts/coconut/.bash_profile" ;;
localhost)
  case "$HOSTNAME" in
  azuki) source "$HOME/hosts/azuki/.bash_profile" ;;
  esac
  ;;
esac

# --- Shell switch ---
if [ "$SSH_PREFER_FISH" = "1" ] && command -v fish >/dev/null 2>&1; then
  exec fish -li
fi
