#!/bin/bash
# start rbenv
eval "$(rbenv init - bash)"

if [ -r ~/.private.sh ]; then . ~/.private.sh; fi

export EDITOR=nvim
export PATH="$HOME/script:$PATH"
export PATH=$PATH:~/.cargo/bin/

export NEOVIDE_FRAMELESS=true
export NEOVIDE_FRAME=none

export NAVI_PATH="~/dotfiles/navi"
