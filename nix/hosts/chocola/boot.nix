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
    default = "saved";
    theme = pkgs.catppuccin-grub;
    splashImage = null;
    configurationName = "yym";
    extraEntries = ''
      menuentry "Windows 11" {
        search --no-floppy --fs-uuid --set=root 58B1-0C54
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.plymouth.enable = true;

}
