{
  description = "youyoumu's flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-nixos-24-05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-nixos-25-05.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-nixos-24-05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    thorium.url = "github:Rishabh5321/thorium_flake";
    thorium.inputs.nixpkgs.follows = "nixpkgs";
    oklch-color-picker.url = "path:./packages/oklch-color-picker";
    oklch-color-picker.inputs.nixpkgs.follows = "nixpkgs";
    nix-secrets.url = "path:./nix-secrets";
  };

  outputs =
    inputs@{ ... }:
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
      };
      nixOnDroidConfigurations = {
        azuki = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import inputs.nixpkgs-nixos-24-05 { system = "aarch64-linux"; };
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [ hosts.azuki ];
        };
      };
    };
}
