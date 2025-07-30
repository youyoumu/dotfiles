set shell := ["bash", "-uc"]

hostname := `
  if [ "$(hostname)" = "localhost" ] && [ -n "$HOSTNAME" ]; 
    then echo "$HOSTNAME"; 
  else 
    hostname; 
  fi
`

default:
    nh os switch ./nix?submodules=1#

update:
    nix flake update --flake ./nix?submodules=1#

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
