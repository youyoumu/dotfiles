#!/usr/bin/env bash

PARENT_PROCESS=$(ps --no-header --pid=$PPID --format=comm)

started_by_fish() { [[ "$PARENT_PROCESS" == "fish" ]]; }
in_script_mode() { [[ -n "${BASH_EXECUTION_STRING}" ]]; }
is_top_level() { [[ "$SHLVL" -eq 1 ]]; }
no_fish() { [[ -n "$NO_FISH" ]]; }

in_nix_shell() {
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

is_allowed_terminal() {
  case "$PARENT_PROCESS" in
  ghostty | .ghostty-wrappe | kitty | .kitty-wrapped | "tmux: server") return 0 ;;
  *) return 1 ;;
  esac
}

if (! in_script_mode && ! no_fish); then
  if (! started_by_fish) || (is_allowed_terminal) || (started_by_fish && in_nix_shell); then
    LOGIN_OPTION=()
    shopt -q login_shell && LOGIN_OPTION=('--login')
    exec fish "${LOGIN_OPTION[@]}"
  fi
fi

# XDG Ninja
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
alias keychain='keychain --absolute --dir "$XDG_RUNTIME_DIR"/keychain'
alias adb='HOME="$XDG_DATA_HOME"/android adb'
