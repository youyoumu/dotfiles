default:
  nh os switch ./nix
update:
  nix flake update --flake ./nix
rebuild:
  sudo nixos-rebuild switch --flake ./nix
clean:
  nh clean all
stow:
  stow .
submodules:
  git submodule update --init --recursive
