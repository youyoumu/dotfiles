#!/bin/env bash

PARENT_PROCESS=$(ps --no-header --pid=$PPID --format=comm)

is_not_already_fish() { [[ "$PARENT_PROCESS" != "fish" ]]; }
is_not_script_mode() { [[ -z "${BASH_EXECUTION_STRING}" ]]; }
is_top_level() { [[ "$SHLVL" -eq 1 ]]; }
is_allowed_terminal() {
  case "$PARENT_PROCESS" in
  ghostty | .ghostty-wrappe | kitty | .kitty-wrapped | "tmux: server") return 0 ;;
  *) return 1 ;;
  esac
}

if (is_not_already_fish && is_not_script_mode) || is_allowed_terminal; then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi
