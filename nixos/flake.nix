{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    thorium.url = "github:Rishabh5321/thorium_flake";
    oklch-color-picker.url = "path:./packages/oklch-color-picker";
  };

  outputs =
    {
      self,
      ...
    }:
    {

      nixosConfigurations.chocola = self.inputs.nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit self system; };
        modules = [
          ./configuration.nix
          self.inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yym = ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          (
            { self, system, ... }:
            {
              environment.systemPackages = [
                self.inputs.nix-alien.packages.${system}.nix-alien
                self.inputs.thorium.packages.${system}.thorium-avx2
                # self.inputs.oklch-color-picker.packages.${system}.default
              ];
            }
          )
        ];
      };

    };
}
