#!/usr/bin/env bash

import_session_conf() {
    local file="${1:-$HOME/.config/environment.d/session.conf}"
    [ -r "$file" ] || return 0

    local content
    content=$(< "$file")

    # Remove comments and blank lines, join continuation lines
    content=$(printf '%s' "$content" | sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d; :a; /\\$/{N; s/\\\n//; ta}')

    while IFS= read -r line; do
        [[ "$line" == *=* ]] && eval "export $line"
    done <<< "$content"
}
