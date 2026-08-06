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
      ANKI_WAYLAND = "1";
      NIRI_CONFIG = "/home/yym/.config/niri/chocola.host.kdl";
    };
    # https://github.com/NixOS/nixpkgs/issues/149812
    extraInit = ''
      export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    '';
  };
}
