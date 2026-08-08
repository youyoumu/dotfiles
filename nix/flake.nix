{
  description = "youyoumu's flake.nix";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    # ================================================================
    nix-on-droid.url = "github:nix-community/nix-on-droid";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    custom-packages.url = "github:Rishabh5321/custom-packages-flake";
    custom-packages.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    # ================================================================
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    oklch-color-picker.url = "path:./packages/oklch-color-picker";
    oklch-color-picker.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    fhs.url = "path:./packages/fhs";
    fhs.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    lute.url = "path:./packages/lute";
    lute.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    nix-secrets.url = "path:./nix-secrets";
    # ================================================================
    nix-unit.url = "github:nix-community/nix-unit";
    nix-unit.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      shared = import ./shared;
      hosts = import ./hosts;
      nixosSystem =
        modules:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit shared inputs; };
          inherit modules;
        };
    in
    {

      nixosConfigurations = {
        chocola = nixosSystem [ hosts.nixosModules.chocola ];
        vanilla = nixosSystem [ hosts.nixosModules.vanilla ];
        coconut = nixosSystem [ hosts.nixosModules.coconut ];
      };
      nixOnDroidConfigurations = {
        azuki = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
          extraSpecialArgs = { inherit inputs; };
          modules = [ hosts.nixOnDroidModules.azuki ];
        };
      };

      tests = import ./tests { inherit inputs; };
      checks =
        let
          forAllSystems = inputs.nixpkgs.lib.genAttrs [ "x86_64-linux" ];
          overrideInputs = builtins.filter (
            name: name != "self" && (builtins.substring 0 5 (inputs.${name}.url or "") != "path:")
          ) (builtins.attrNames inputs);
          overrideFlags = builtins.concatStringsSep " " (
            builtins.map (name: "--override-input ${name} ${inputs.${name}}") overrideInputs
          );
        in
        forAllSystems (system: {
          default =
            inputs.nixpkgs.legacyPackages.${system}.runCommand "nix-unit-tests"
              {
                nativeBuildInputs = [ inputs.nix-unit.packages.${system}.default ];
              }
              ''
                export HOME="$(realpath .)"
                nix-unit \
                  --eval-store "$HOME" \
                  --accept-flake-config \
                  --extra-experimental-features flakes \
                  ${overrideFlags} \
                  --flake ${inputs.self}#tests
                touch $out
              '';
        });
    };

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
