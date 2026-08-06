{
  lib,
  config,
  options,
  pkgs,
  inputs,
  system,
  ...
}:
{
  environment = {
    variables.EDITOR = "nvim";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      NIRI_CONFIG = "/home/yym/.config/niri/coconut.host.kdl";
    };
  };
}
