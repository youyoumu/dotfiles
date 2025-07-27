default:
  nh os switch ./nixos
update:
  nix flake update --flake ./nixos
rebuild:
  sudo nixos-rebuild switch --flake ./nixos
clean:
  nh clean all
stow:
  stow .
submodules:
  git submodule update --init --recursive
