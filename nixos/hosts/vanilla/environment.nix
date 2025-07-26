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
  environment.variables.EDITOR = "nvim";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
