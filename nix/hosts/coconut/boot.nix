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
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    theme = pkgs.catppuccin-grub;
    splashImage = null;
    configurationName = "yym";
    extraEntries = ''
      menuentry "Windows 11" {
        search --no-floppy --fs-uuid --set=root 0B1B-7845
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
  boot.supportedFilesystems = [ "ntfs" ];
}
