fish_vi_key_bindings
set -g fish_greeting
fish_config theme choose catppuccin-mocha

if not test is_home_manager
    if type -q starship
        starship init fish | source
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q navi
        navi widget fish | source
    end
else
    # 
end

# eza
alias list="command ls"
alias ls="eza --long --icons --git --all --header --binary --no-permissions \
          --no-user --mounts --grid --group-directories-first"
alias lsl="eza --long --icons --header --all --binary --mounts \
          --group-directories-first --group"
alias lt="eza --tree --icons --all --group-directories-first"
alias lt1="eza --tree --level=2 --icons --all --group-directories-first"
alias lt2="eza --tree --level=2 --icons --all --group-directories-first"
alias lt3="eza --tree --level=3 --icons --all --group-directories-first"
alias lt4="eza --tree --level=4 --icons --all --group-directories-first"
alias lt5="eza --tree --level=5 --icons --all --group-directories-first"

function rm
    echo "Usage of 'rm' is disabled. Use 'del' instead."
    return 1
end
alias remove="command rm"
alias del="trash"
alias s="sesh connect (sesh list | fzf)"
alias lg="lazygit"
alias n="nvim"
alias p="pnpm"
alias j="just"

function nd
    nohup neovide $argv >/dev/null 2>&1 &
    disown
    exit
end

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
    case coconut
        source ~/.config/fish/hosts/coconut.fish
    case localhost
        switch $HOSTNAME
            case azuki
                source ~/.config/fish/hosts/azuki.fish
        end
end
