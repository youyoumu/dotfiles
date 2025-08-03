#!/bin/env bash

if [ -r ~/.private.sh ]; then . ~/.private.sh; fi

export EDITOR=nvim
export PATH="$HOME/script:$PATH"
export PATH=$PATH:~/.cargo/bin/
export PATH="$HOME/.npm-global/bin:$PATH"

export NEOVIDE_FRAMELESS=true
export NEOVIDE_FRAME=none

export NAVI_PATH="~/dotfiles/navi"

case "$(hostname)" in
chocola)
  source ~/hosts/chocola/.bash_profile
  ;;
vanilla)
  source ~/hosts/vanilla/.bash_profile
  ;;
coconut)
  source ~/hosts/coconut/.bash_profile
  ;;
localhost)
  case "$HOSTNAME" in
  azuki)
    source ~/hosts/azuki/.bash_profile
    ;;
  esac
  ;;
esac

if [ "$SSH_PREFER_FISH" = "1" ] && command -v fish >/dev/null 2>&1; then
  exec fish -li
fi
