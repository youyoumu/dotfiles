{
  lib,
  config,
  options,
  pkgs,
  inputs,
  system,
  ...
}:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
