fish_vi_key_bindings

starship init fish | source

# doesn't work with fish_vi_key_bindings
# if status is-interactive
#     # ctrl-delete
#     bind \e\[3\;5~ kill-word
#     # ctrl-backspace
#     bind \b backward-kill-word
# end

# start rbenv
status --is-interactive; and rbenv init - fish | source

# start pyenv
pyenv init - fish | source

# zoxide
zoxide init fish | source
#alias cd="z"

# eza
alias ls="eza --long --icons --git --all --binary --no-permissions --no-user --mounts --grid --group-directories-first"

# sesh
alias s="sesh connect (sesh list | fzf)"

# lazygit
alias lg="lazygit"

# nvim
alias n="nvim"
alias nd="neovide &"

# pnpm
alias p="pnpm"

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
