{
  description = "youyoumu's flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    thorium.url = "github:Rishabh5321/thorium_flake";
    oklch-color-picker.url = "path:./packages/oklch-color-picker";
    "nixpkgs.nixos-25.05".url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-secrets.url = "path:./nix-secrets";
  };

  outputs =
    {
      ...
    }@inputs:
    let
      shared = import ./shared;
    in
    {
      nixosConfigurations = {
        chocola = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system shared;
          };
          modules = [
            ./hosts/chocola/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };
        vanilla = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system shared;
          };
          modules = [
            ./hosts/vanilla/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.agenix.nixosModules.default
            inputs.nix-secrets.nixosModules.vanilla
          ];
        };
      };
    };
}
