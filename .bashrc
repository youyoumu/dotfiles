#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PARENT_PROCESS=$(ps --no-header --pid=$PPID --format=comm)

is_no_fish() { [[ -n "$NO_FISH" ]]; }
is_exec_fish() { [[ -n "$__EXEC_FISH" ]]; }
is_top_level_process() { [[ "$SHLVL" -eq 1 ]]; }
is_in_script_mode() { [[ -n "${BASH_EXECUTION_STRING}" ]]; }
is_started_by_fish() { [[ "$PARENT_PROCESS" == "fish" ]]; }
is_started_by_terminal() {
  local terminals=("ghostty" ".ghostty-wrapped" "kitty" ".kitty-wrapped" "tmux: server")
  local term
  for term in "${terminals[@]}"; do
    if [[ "$PARENT_PROCESS" == "$term" ]]; then
      return 0
    fi
  done
  return 1
}

is_in_nix_shell() {
  [[ -n "${IN_NIX_SHELL}" ]] && return 0

  local path_entry
  local nix_count=0

  IFS=':' read -ra PATH_ENTRIES <<<"$PATH"
  for path_entry in "${PATH_ENTRIES[@]}"; do
    if [[ "$path_entry" == /nix/store* ]]; then
      ((nix_count++))
      [[ $nix_count -gt 1 ]] && return 0
    fi
  done

  return 1
}

execute_fish() {
  if (command -v fish >/dev/null 2>&1); then
    unset __EXEC_FISH
    LOGIN_OPTION=()
    shopt -q login_shell && LOGIN_OPTION=('--login')
    exec fish "${LOGIN_OPTION[@]}"
  fi
}

if is_exec_fish; then
  execute_fish
elif ! is_in_script_mode && ! is_no_fish; then
  if ! is_started_by_fish || is_started_by_terminal; then
    execute_fish
  elif is_started_by_fish && is_in_nix_shell; then
    execute_fish
  fi
fi

alias stow='stow --simulate'
# XDG Ninja
alias wget='wget --hsts-file="$XDG_DATA_HOME"/wget-hsts'
alias keychain='keychain --absolute --dir "$XDG_RUNTIME_DIR"/keychain'
alias adb='HOME="$XDG_DATA_HOME"/android adb'
