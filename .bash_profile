#!/bin/env bash

if [ -r "$HOME/.private.sh" ]; then . "$HOME/.private.sh"; fi

export EDITOR=nvim
export PATH="$HOME/scripts:$PATH"
export PATH="$PATH:$HOME/.cargo/bin/"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export NEOVIDE_FRAMELESS=true
export NEOVIDE_FRAME=none

export NAVI_PATH="$HOME/dotfiles/navi"

case "$(hostname)" in
chocola)
  source "$HOME/hosts/chocola/.bash_profile"
  ;;
vanilla)
  source "$HOME/hosts/vanilla/.bash_profile"
  ;;
coconut)
  source "$HOME/hosts/coconut/.bash_profile"
  ;;
localhost)
  case "$HOSTNAME" in
  azuki)
    source "$HOME/hosts/azuki/.bash_profile"
    ;;
  esac
  ;;
esac

if [ "$SSH_PREFER_FISH" = "1" ] && command -v fish >/dev/null 2>&1; then
  exec fish -li
fi
