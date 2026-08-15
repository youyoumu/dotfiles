{
  config,
  pkgs,
  shared,
  ...
}:

{
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  boot.loader.grub.extraEntries = shared.util.grubWindowsEntry "EA7C-2654";

  environment.sessionVariables.NIRI_CONFIG = "${config.users.users.yym.home}/.config/niri/chocola.host.kdl";

  system.stateVersion = "25.05";
}
