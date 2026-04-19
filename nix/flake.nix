{
  description = "youyoumu's flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # ================================================================
    nix-on-droid.url = "github:nix-community/nix-on-droid";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    thorium.url = "github:Rishabh5321/thorium_flake";
    thorium.inputs.nixpkgs.follows = "nixpkgs";
    # ================================================================
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs.url = "github:noctalia-dev/noctalia-qs";
    noctalia-qs.inputs.nixpkgs.follows = "nixpkgs";
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
    nix-secrets.url = "path:./nix-secrets";
  };

  outputs =
    inputs:
    let
      shared = import ./shared;
      hosts = import ./hosts;
    in
    {
      nixosConfigurations = {
        chocola = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system shared;
          };
          modules = [
            hosts.chocola
            inputs.home-manager.nixosModules.home-manager
            inputs.agenix.nixosModules.default
            inputs.nix-secrets.nixosModules.chocola
            inputs.nix-index-database.nixosModules.default
            { programs.nix-index-database.comma.enable = true; }
          ];
        };
        vanilla = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system shared;
          };
          modules = [
            hosts.vanilla
            inputs.home-manager.nixosModules.home-manager
            inputs.agenix.nixosModules.default
            inputs.nix-secrets.nixosModules.vanilla
          ];
        };
        coconut = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system shared;
          };
          modules = [
            hosts.coconut
            inputs.home-manager.nixosModules.home-manager
          ];
        };

      };
      nixOnDroidConfigurations = {
        azuki = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [ hosts.azuki ];
        };
      };
    };
}
