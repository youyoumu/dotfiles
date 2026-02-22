{
  lib,
  config,
  options,
  pkgs,
  inputs,
  system,
  ...
}:
let
  commonOptions = [
    "nosuid" # Prevents execution of set-user-identifier (SUID) or set-group-identifier (SGID) binaries.
    "nodev" # Blocks interpretation of device files (like /dev/sda, /dev/null) on that filesystem.
    "nofail" # Don't fail the boot if the filesystem is missing or cannot be mounted.
    "x-gvfs-show" # A special flag for GNOME and other GVFS-based file managers (like Nautilus).
  ];
in
{
  fileSystems."/mnt/ChocolateBox1T" = {
    device = "/dev/disk/by-uuid/2393FC547EB4A8F5";
    fsType = "auto";
    options = commonOptions;
  };
  fileSystems."/mnt/SugarCube500G" = {
    device = "/dev/disk/by-uuid/6F4797EC212CC9C8";
    fsType = "auto";
    options = commonOptions;
  };
  fileSystems."/mnt/HoneyGlaze685G" = {
    device = "/dev/disk/by-uuid/6C0ACF540ACF19CA";
    fsType = "auto";
    options = commonOptions;
  };
  fileSystems."/mnt/WarmBrew265G" = {
    device = "/dev/disk/by-uuid/5c33ed85-3938-43eb-b5c8-4cc4df3ae060";
    fsType = "auto";
    options = commonOptions;
  };
}
