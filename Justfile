set shell := ["bash", "-uc"]

hostname := `
  if [[ "$(hostname)" == "localhost" ]] && [[ -n "$HOSTNAME" ]]; 
    then echo "$HOSTNAME"; 
  else 
    hostname; 
  fi
`
default: rebuild-nh

update input="":
    nix flake update {{ input }} --flake ./nix

rebuild:
    sudo nixos-rebuild switch --flake ./nix

rebuild-nh:
    #!/usr/bin/env bash
    if [[ "{{ hostname }}" == "azuki" ]]; then
      nix-on-droid switch --flake ./nix#azuki;
    else
      nh os switch ./nix
    fi

clean:
    sudo nh clean all

meta:
    nix flake metadata ./nix

history:
    nix profile history --profile /nix/var/nix/profiles/system

repl:
    nix repl ./nix

check:
    nix flake check ./nix

test:
    nix-unit --flake ./nix#tests

format:
    treefmt

stow:
    #!/usr/bin/env bash
    # TODO: skip if nix 
    mkdir -p ~/.config/fish
    if [[ "{{ hostname }}" == "chocola" ]]; then
      stow . --ignore=".config/fish/*"
    else
      stow .
    fi

submodules:
    git submodule update --init --recursive

keychain:
    keychain ~/.ssh/{{ hostname }}
