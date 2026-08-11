{ pkgs, inputs }:
let
  lib = pkgs.lib;
  shared = import ../shared;
  hosts = import ../hosts;

  hostModules = lib.mapAttrs (_: path: import path { inherit shared; }) hosts.nixosModules;

  openssh = shared.nixosModules.services.openssh;

  opensshEnabled = name: lib.elem openssh hostModules.${name}.imports;
in
{
  "test: openssh enabled on chocola" = {
    expr = opensshEnabled "chocola";
    expected = true;
  };
  "test: openssh enabled on vanilla" = {
    expr = opensshEnabled "vanilla";
    expected = true;
  };
  "test: openssh disabled on coconut" = {
    expr = opensshEnabled "coconut";
    expected = false;
  };
}
