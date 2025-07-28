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
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./disks.nix
    ./networking.nix
    ./services.nix
    ./programs.nix
    ./packages.nix
    ./fonts.nix
    ./environment.nix
    ./overlays.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yym = {
    isNormalUser = true;
    description = "youyoumu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = [
    ];
    linger = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
