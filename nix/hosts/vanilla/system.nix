{ ... }:

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

  users.users.yym.linger = true;

  system.stateVersion = "25.05";
}
