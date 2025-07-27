#!/bin/env bash

PARENT_PROCESS=$(ps --no-header --pid=$PPID --format=comm)

# Only exec fish if:
if [[ 
  # The parent process isn't already fish
  $PARENT_PROCESS != "fish" &&

  # Bash wasn't started in script mode (BASH_EXECUTION_STRING is empty)
  -z ${BASH_EXECUTION_STRING} &&

  # We're at shell level 1 (SHLVL == 1) — i.e., this is the top-level shell
  ( ${SHLVL} -eq 1) 

  ]] || [[

  # Or we are launching bash from one these programs
  $PARENT_PROCESS == "kitty" ||
  $PARENT_PROCESS == ".kitty-wrapped" ||
  $PARENT_PROCESS == "tmux: server" 

  ]]; then


  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi

