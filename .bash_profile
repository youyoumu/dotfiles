#!/bin/bash
# start rbenv
eval "$(rbenv init - bash)"

if [ -r ~/.private.sh ]; then . ~/.private.sh; fi

export EDITOR=nvim
export PATH="$HOME/script:$PATH"

export NEOVIDE_FRAMELESS=true
export NEOVIDE_FRAME=none
