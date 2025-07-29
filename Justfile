default:
  nh os switch ./nix?submodules=1#
azuki:
  nix-on-droid switch --flake ./nix?submodules=1#azuki
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
