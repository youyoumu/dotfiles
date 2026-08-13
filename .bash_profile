#!/bin/env bash

if [[ -r "$HOME/.private.sh" ]]; then . "$HOME/.private.sh"; fi

if command -v lua >/dev/null 2>&1; then
  export LUA_PATH="$HOME/dotfiles/?.lua;$HOME/dotfiles/?/init.lua;;"
  _env="$(lua "$HOME/dotfiles/scripts/import_session_conf.lua" 2>/dev/null)"
  eval "$_env"
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

if [[ "$SSH_PREFER_FISH" = "1" ]]; then
  export __EXEC_FISH=1
fi

if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
