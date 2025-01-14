if status is-interactive
    # ctrl-delete
    bind \e\[3\;5~ kill-word
    # ctrl-backspace
    bind \b backward-kill-word
end

# start rbenv
status --is-interactive; and rbenv init - fish | source

# zoxide
zoxide init fish | source
#alias cd="z"

# eza
alias ls="eza --long --icons --git --all --bytes --no-permissions --no-user --mounts --grid --group-directories-first"

# sesh
alias s="sesh connect (sesh list | fzf)"

# lazygit
alias lg="lazygit"

# nvim
alias n="nvim ."
alias nd="neovide . &"

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
