{ config, pkgs, shared, ... }:

{
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  boot.loader.grub.extraEntries = shared.util.grubWindowsEntry "58B1-0C54";

  environment.sessionVariables.NIRI_CONFIG = "${config.users.users.yym.home}/.config/niri/chocola.host.kdl";

  system.stateVersion = "25.05";
}
