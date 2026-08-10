#!/bin/env bash

export LUA_PATH="$HOME/dotfiles/?.lua;$HOME/dotfiles/?/init.lua;;"

if [ -r "$HOME/.private.sh" ]; then . "$HOME/.private.sh"; fi

# --- Import environment.d/session.conf ---
if command -v lua >/dev/null 2>&1; then
  _env="$(lua "$HOME/dotfiles/scripts/import_session_conf.lua" 2>/dev/null)" && eval "$_env"
  unset _env
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
