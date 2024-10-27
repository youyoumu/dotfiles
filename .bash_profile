#!/bin/bash
# start rbenv
eval "$(rbenv init - bash)"

if [ -r ~/.private.sh ]; then . ~/.private.sh; fi

export EDITOR=micro
export PATH="$HOME/script:$PATH"