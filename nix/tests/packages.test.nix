{ pkgs, inputs }:
let
  packages = {
    default = import ../shared/packages.nix { inherit pkgs inputs; };
    desktop = import ../shared/packages.desktop.nix { inherit pkgs inputs; };
  };

  extractPackageNames =
    config:
    let
      packages = config.environment.systemPackages or [ ];
      getName = pkg: (builtins.parseDrvName pkg.name).name;
    in
    map getName packages;

  packageNames = {
    default = extractPackageNames packages.default;
    desktop = extractPackageNames packages.desktop;
  };

  duplicates = builtins.filter (name: builtins.elem name packageNames.desktop) packageNames.default;
in
{
  "test: No duplicate packages between default and desktop" = {
    expr = duplicates;
    expected = [ ];
  };
}
