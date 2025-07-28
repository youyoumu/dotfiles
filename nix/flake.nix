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
  };

  outputs =
    {
      ...
    }@inputs:
    {
      nixosConfigurations = {
        chocola = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/chocola/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yym = ./home.nix;
            }
          ];
        };
        vanilla = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/vanilla/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yym = ./home.nix;
            }
            inputs.agenix.nixosModules.default
          ];
        };
      };
    };
}
