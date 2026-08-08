{ pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        default = "saved";
        theme = pkgs.catppuccin-grub;
        splashImage = null;
        configurationName = "yym";
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
