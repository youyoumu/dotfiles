{
  nixosModules = {
    chocola = ./chocola;
    vanilla = ./vanilla;
    coconut = ./coconut;
  };
  nixOnDroidModules = {
    azuki = ./azuki/nix-on-droid.nix;
  };
}
