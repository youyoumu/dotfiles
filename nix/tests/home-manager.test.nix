{ pkgs, inputs }:
let
  lib = pkgs.lib;
  shared = import ../shared;
  hosts = import ../hosts;

  hostModules = lib.mapAttrs (_: path: import path { inherit shared; }) hosts.nixosModules;

  homeManagerDesktop = shared.nixosModules.home-manager.desktop;

  homeManagerDesktopEnabled = name: lib.elem homeManagerDesktop hostModules.${name}.imports;
in
{
  "test: home-manager.desktop enabled on chocola" = {
    expr = homeManagerDesktopEnabled "chocola";
    expected = true;
  };
  "test: home-manager.desktop enabled on coconut" = {
    expr = homeManagerDesktopEnabled "coconut";
    expected = true;
  };
  "test: home-manager.desktop disabled on vanilla" = {
    expr = homeManagerDesktopEnabled "vanilla";
    expected = false;
  };
}
