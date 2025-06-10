#!/bin/bash

# Only exec fish if:
# - The parent process isn’t already fish
# - Bash wasn't started in script mode (BASH_EXECUTION_STRING is empty)
# - We're at shell level 1 (SHLVL == 1) — i.e., this is the top-level shell

# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]; then
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]; then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi
