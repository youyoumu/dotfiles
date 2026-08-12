{ pkgs, inputs }:
let
  lib = pkgs.lib;
  shared = import ../shared;
  hosts = import ../hosts;

  hostModules = lib.mapAttrs (_: path: import path { inherit shared; }) hosts.nixosModules;
  cloudflared = shared.nixosModules.services.cloudflared;

  hostServices = lib.mapAttrs (
    name: _: import ../hosts/${name}/services.nix { inherit inputs; }
  ) hosts.nixosModules;
  tunnelNames = name: hostServices.${name}.services.cloudflared.tunnelNames or [ ];
in
{
  "test: cloudflared enabled on chocola" = {
    expr = lib.elem cloudflared hostModules.chocola.imports;
    expected = true;
  };
  "test: cloudflared enabled on vanilla" = {
    expr = lib.elem cloudflared hostModules.vanilla.imports;
    expected = true;
  };
  "test: cloudflared disabled on coconut" = {
    expr = lib.elem cloudflared hostModules.coconut.imports;
    expected = false;
  };

  "test: chocola has only chocola-tunnel" = {
    expr = tunnelNames "chocola";
    expected = [ "chocola-tunnel" ];
  };
  "test: vanilla has only vanilla-tunnel" = {
    expr = tunnelNames "vanilla";
    expected = [ "vanilla-tunnel" ];
  };
}
