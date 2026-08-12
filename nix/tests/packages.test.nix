{ pkgs, inputs }:
let
  lib = pkgs.lib;
  pkgsAarch64 = import inputs.nixpkgs { system = "aarch64-linux"; };

  packageConfigs = {
    default = import ../shared/packages.nix { inherit pkgs inputs; };
    toolchain = import ../shared/packages.toolchain.nix { inherit pkgs; };
    desktop = import ../shared/packages.desktop.nix { inherit pkgs inputs; };
  };

  hostPackageConfigs = {
    chocola = import ../hosts/chocola/packages.nix { inherit pkgs; };
    coconut = import ../hosts/coconut/packages.nix { inherit pkgs; };
    vanilla = import ../hosts/vanilla/packages.nix { inherit pkgs; };
    azuki = import ../hosts/azuki/nix-on-droid.nix { pkgs = pkgsAarch64; };
  };

  extractPackages =
    config:
    let
      packages = config.environment.systemPackages or config.environment.packages;
      getName = pkg: (builtins.parseDrvName pkg.name).name;
    in
    map getName packages;

  packages = {
    default = extractPackages packageConfigs.default;
    toolchain = extractPackages packageConfigs.toolchain;
    desktop = extractPackages packageConfigs.desktop;
  };

  hostPackages = {
    chocola =
      extractPackages packageConfigs.default
      ++ extractPackages packageConfigs.toolchain
      ++ extractPackages packageConfigs.desktop
      ++ extractPackages hostPackageConfigs.chocola;
    coconut =
      extractPackages packageConfigs.default
      ++ extractPackages packageConfigs.toolchain
      ++ extractPackages packageConfigs.desktop
      ++ extractPackages hostPackageConfigs.coconut;
    vanilla =
      extractPackages packageConfigs.default
      ++ extractPackages packageConfigs.toolchain
      ++ extractPackages hostPackageConfigs.vanilla;
    azuki = extractPackages hostPackageConfigs.azuki;
  };

  duplicates = list: lib.unique (builtins.filter (name: lib.count (n: n == name) list > 1) list);
in
{
  "test: No duplicate packages between default, toolchain, and desktop" = {
    expr = duplicates (packages.default ++ packages.toolchain ++ packages.desktop);
    expected = [ ];
  };

  "test: No duplicate packages on chocola" = {
    expr = duplicates hostPackages.chocola;
    expected = [ ];
  };
  "test: No duplicate packages on coconut" = {
    expr = duplicates hostPackages.coconut;
    expected = [ ];
  };
  "test: No duplicate packages on vanilla" = {
    expr = duplicates hostPackages.vanilla;
    expected = [ ];
  };
  "test: No duplicate packages on azuki" = {
    expr = duplicates hostPackages.azuki;
    expected = [ ];
  };
}
