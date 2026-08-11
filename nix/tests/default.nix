{ inputs }:
let
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

  tests = {
    packages = import ./packages.test.nix { inherit pkgs inputs; };
    services = import ./services.test.nix { inherit pkgs inputs; };
    cloudflared = import ./cloudflared.test.nix { inherit pkgs inputs; };
  };
in
tests.packages // tests.services // tests.cloudflared
