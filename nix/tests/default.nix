{ inputs }:
let
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

  packages = import ./packages.test.nix { inherit pkgs inputs; };
in
packages
