#!/usr/bin/env fish

function update
    nix flake update $argv --flake ./nix
end

function rebuild
    sudo nixos-rebuild switch --flake ./nix
end

function rebuild-nh
    set -l host (_get_hostname)
    if test "$host" = azuki
        nix-on-droid switch --flake ./nix#azuki
    else
        nh os switch ./nix
    end
end

function default
    rebuild-nh
end

function clean
    sudo nh clean all
end

function meta
    nix flake metadata ./nix
end

function history
    nix profile history --profile /nix/var/nix/profiles/system
end

function repl
    nix repl ./nix
end

function check
    nix flake check ./nix
end

function unit-test
    nix-unit --flake ./nix#tests
end

function stow
    set -l host (_get_hostname)
    mkdir -p ~/.config/fish
    if test "$host" = chocola
        command stow . --ignore=".config/fish/*"
    else
        command stow .
    end
end

function submodules
    git submodule update --init --recursive
end

function keychain
    set -l host (_get_hostname)
    command keychain ~/.ssh/$host
end

function _get_hostname
    set -l host_val (hostname)
    if test "$host_val" = localhost -a -n "$HOSTNAME"
        echo "$HOSTNAME"
    else
        echo "$host_val"
    end
end

$argv
