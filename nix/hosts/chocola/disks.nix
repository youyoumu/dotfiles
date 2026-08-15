{ ... }:
let
  commonOptions = [
    "nosuid" # Prevents execution of set-user-identifier (SUID) or set-group-identifier (SGID) binaries.
    "nodev" # Blocks interpretation of device files (like /dev/sda, /dev/null) on that filesystem.
    "nofail" # Don't fail the boot if the filesystem is missing or cannot be mounted.
    "x-gvfs-show" # A special flag for GNOME and other GVFS-based file managers (like Nautilus).
  ];

  # Modern ntfs3 driver specific options for proper user mapping
  ntfsOptions = commonOptions ++ [
    "rw"
    "uid=1000" # Maps file ownership to uid=1000 (yym)
    "gid=100" # Maps group ownership to gid=100 (users)
    "fmask=0022" # Gives read/write/execute permissions to files (needed by Steam)
    "dmask=0022" # Gives proper permissions to directories
    "windows_names" # Prevents creating files with characters Windows dislikes
  ];
in
{
  fileSystems = {
    "/mnt/h1t-mochi" = {
      device = "/dev/disk/by-uuid/2393FC547EB4A8F5";
      fsType = "auto";
      options = ntfsOptions;
    };
    "/mnt/h500g-dango" = {
      device = "/dev/disk/by-uuid/6F4797EC212CC9C8";
      fsType = "auto";
      options = ntfsOptions;
    };
    "/mnt/n1t-usagi" = {
      device = "/dev/disk/by-uuid/B0EA810AEA80CDD2";
      fsType = "auto";
      options = ntfsOptions;
    };
    "/mnt/n1t-usagi2" = {
      device = "/dev/disk/by-uuid/5c33ed85-3938-43eb-b5c8-4cc4df3ae060";
      fsType = "auto";
      options = commonOptions;
    };
  };
}
