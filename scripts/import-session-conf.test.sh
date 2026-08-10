#!/usr/bin/env bash

source "$(dirname "$0")/lib.sh"
source "$(dirname "$0")/import-session-conf.sh"

test_file=$(mktemp)
cat >"$test_file" <<'EOF'
NIXOS_OZONE_WL=1
ANKI_WAYLAND=1

# --- Editor ---
EDITOR=nvim

# --- PATH ---
PATH=$PATH\
:$HOME/.local/bin\
:$HOME/scripts\
:$HOME/.cargo/bin

# --- Tools ---
NAVI_PATH=$HOME/dotfiles/navi

# --- Appearance ---
NEOVIDE_FRAMELESS=true
NEOVIDE_FRAME=none
EOF

echo "=== Test: import_session_conf ==="
import_session_conf "$test_file"

echo "Simple assignments:"
assert_eq "EDITOR" "nvim" "$EDITOR"
assert_eq "NIXOS_OZONE_WL" "1" "$NIXOS_OZONE_WL"
assert_eq "ANKI_WAYLAND" "1" "$ANKI_WAYLAND"

echo "Line continuations with \$HOME expansion:"
assert_contains "PATH has .local/bin" "$HOME/.local/bin" "$PATH"
assert_contains "PATH has scripts" "$HOME/scripts" "$PATH"
assert_contains "PATH has .cargo/bin" "$HOME/.cargo/bin" "$PATH"

echo "Line continuations without expansion:"
assert_eq "NAVI_PATH" "$HOME/dotfiles/navi" "$NAVI_PATH"

echo "=== PATH ==="
echo "$PATH" | tr ":" "\n"

rm "$test_file"
print_results
