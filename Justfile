set shell := ["bash", "-uc"]

hostname := `
  if [[ "$(hostname)" == "localhost" ]] && [[ -n "$HOSTNAME" ]]; 
    then echo "$HOSTNAME"; 
  else 
    hostname; 
  fi
`

default:
    #!/usr/bin/env bash
    if [[ "{{ hostname }}" == "azuki" ]]; then
      nix-on-droid switch --flake ./nix?submodules=1#azuki;
    else
      nh os switch ./nix?submodules=1#;
    fi

update one:
    nix flake update {{ one }} --flake ./nix?submodules=1#

rebuild:
    sudo nixos-rebuild switch --flake ./nix?submodules=1#

clean:
    sudo nh clean all

meta:
    nix flake metadata ./nix?submodules=1#

stow:
    stow .

submodules:
    git submodule update --init --recursive

keychain:
    keychain ~/.ssh/{{ hostname }}
