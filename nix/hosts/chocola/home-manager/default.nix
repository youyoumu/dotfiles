{
  shared,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit shared;
    };
    users.yym = ./home.nix;
  };
}
