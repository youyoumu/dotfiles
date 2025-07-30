fish_vi_key_bindings

set -g fish_greeting

starship init fish | source

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

# just
alias j="just"

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

switch (hostname)
    case chocola
        source ~/.config/fish/hosts/chocola.fish
    case vanilla
        source ~/.config/fish/hosts/vanilla.fish
end
