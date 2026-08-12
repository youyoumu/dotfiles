{ shared, ... }:
{
  imports = [
    shared.nixosModules.system
    shared.nixosModules.home-manager.default
    shared.nixosModules.home-manager.desktop
    shared.nixosModules.fonts
    shared.nixosModules.ime
    shared.nixosModules.gstreamer
    shared.nixosModules.boot.grub
    shared.nixosModules.packages.default
    shared.nixosModules.packages.desktop
    shared.nixosModules.services.default
    shared.nixosModules.services.desktop
    shared.nixosModules.services.openssh
    shared.nixosModules.systemd.sync-gdm-monitors
    shared.nixosModules.services.cloudflared
    ./system.nix
    ./hardware.nix
    ./disks.nix
    ./networking.nix
    ./services.nix
    ./packages.nix
  ];
}
