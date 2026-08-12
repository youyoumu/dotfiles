{ shared, ... }:
{
  home-manager.users.yym.imports = [ shared.nixosModules.dconf ];
}
