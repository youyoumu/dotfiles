{ inputs, shared, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit shared;
    };
    users.yym = {
      imports = [ shared.nixosModules.user.yym ];
    };
  };
}
