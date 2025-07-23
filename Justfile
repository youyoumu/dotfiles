default:
  nh os switch ./nixos
rebuild:
  sudo nixos-rebuild switch --flake ./nixos
clean:
  nh clean all
