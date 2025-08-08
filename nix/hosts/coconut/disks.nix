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
  # fileSystems."/mnt/HDD-1TB" = {
  #   device = "/dev/disk/by-uuid/4E2C1B592C1B3C01";
  #   fsType = "auto";
  #   options = [
  #     "nosuid" # Prevents execution of set-user-identifier (SUID) or set-group-identifier (SGID) binaries.
  #     "nodev" # Blocks interpretation of device files (like /dev/sda, /dev/null) on that filesystem.
  #     "nofail" # Don't fail the boot if the filesystem is missing or cannot be mounted.
  #     "x-gvfs-show" # A special flag for GNOME and other GVFS-based file managers (like Nautilus).
  #   ];
  # };
}
