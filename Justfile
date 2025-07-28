default:
  nh os switch ./nix?submodules=1#
update:
  nix flake update --flake ./nix?submodules=1#
rebuild:
  sudo nixos-rebuild switch --flake ./nix?submodules=1#
clean:
  nh clean all
stow:
  stow .
submodules:
  git submodule update --init --recursive
