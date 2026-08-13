#!/bin/env bash

if [[ -r "$HOME/.private.sh" ]]; then . "$HOME/.private.sh"; fi

if command -v lua >/dev/null 2>&1; then
  export LUA_PATH="$HOME/dotfiles/?.lua;$HOME/dotfiles/?/init.lua;;"
  _lua='require("lib.environmentd").print_env(arg[1])'
  _env="$(lua - "$HOME/.config/environment.d/session.conf" 2>/dev/null <<<"$_lua")"
  eval "$_env"
  unset _env _lua
fi

case "$(hostname)" in
chocola) source "$HOME/.config/bash/chocola.bash_profile" ;;
vanilla) source "$HOME/.config/bash/vanilla.bash_profile" ;;
coconut) source "$HOME/.config/bash/coconut.bash_profile" ;;
localhost)
  case "$HOSTNAME" in
  azuki) source "$HOME/.config/bash/azuki.bash_profile" ;;
  esac
  ;;
esac

if [[ "$SSH_PREFER_FISH" = "1" ]]; then
  export __EXEC_FISH=1
fi

if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
