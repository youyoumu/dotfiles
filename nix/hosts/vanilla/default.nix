{ shared, ... }:
{
  imports = [
    shared.nixosModules.system
    shared.nixosModules.home-manager
    shared.nixosModules.packages.default
    shared.nixosModules.services.default
    shared.nixosModules.services.openssh
    shared.nixosModules.services.cloudflared
    ./system.nix
    ./hardware.nix
    ./disks.nix
    ./networking.nix
    ./services.nix
    ./packages.nix
  ];
}
