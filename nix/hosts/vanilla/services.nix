{ inputs, ... }:
{
  imports = [
    inputs.nix-secrets.nixosModules.vanilla
  ];

  # https://github.com/NixOS/nixpkgs/issues/479809
  specialisation = {
    withGnome.configuration = {
      services = {
        desktopManager.gnome.enable = true;
      };
    };
  };

  services = {
    desktopManager.gnome.enable = false;
    cloudflared.tunnelNames = [ "vanilla-tunnel" ];
  };
}
