fish_vi_key_bindings
set -g fish_greeting
fish_config theme choose catppuccin-mocha

if not test __is_home_manager_config
    if type -q starship
        starship init fish | source
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q navi
        navi widget fish | source
    end
end

function run --description "Run local run.fish file"
    if test -f ./run.fish
        if test (count $argv) -eq 0
            ./run.fish default
        else
            ./run.fish $argv
        end
    else
        echo "Error: No ./run.fish found in $(pwd)" >&2
        return 1
    end
end

function __fish_run_get_functions
    set -l script_path "./run.fish"
    if test -f $script_path
        # TODO: unit-test this
        string match -rg '^\s*function\s+([^\s]+)' <$script_path
    end
end

complete -c run -f -a "(__fish_run_get_functions)"

# eza
alias list="command ls"
alias ls="eza --long --icons --git --all --header --no-permissions \
          --no-user --mounts --grid --group-directories-first"
alias lsl="eza --long --icons --header --all --binary --mounts \
          --group-directories-first --group"
function lt --argument-names level
    if not test -n "$level"
        command eza --tree --level=1 --icons --all --group-directories-first
    else if test "$level" -eq 0
        command eza --tree --icons --all --group-directories-first
    else
        command eza --tree --level=$level --icons --all --group-directories-first
    end
end

function rm
    echo "Usage of 'rm' is disabled. Use 'del' instead."
    return 1
end
alias remove="command rm"
alias del="trash"
alias s="sesh connect (sesh list | fzf)"
alias lg="lazygit"
alias n="nvim"
alias zvim="NVIM_APPNAME=zvim nvim"
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
