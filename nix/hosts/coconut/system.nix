{ config, shared, ... }:

{
  boot.loader.grub.extraEntries = shared.util.grubWindowsEntry "0B1B-7845";

  environment.sessionVariables.NIRI_CONFIG = "${config.users.users.yym.home}/.config/niri/coconut.host.kdl";

  system.stateVersion = "25.05";
}
