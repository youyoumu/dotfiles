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
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.nh = {
    enable = true;
    flake = "/home/yym/dotfiles/nix";
    # clean.enable = true;
    # clean.extraArgs = "--keep-since 4d --keep 3";
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      wayland
      libxkbcommon
      libGL
      icu
    ];
  };
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/mnt/WarmBrew128G/chocola/var/lib/docker";
    };
  };
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.firefox.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.adb.enable = true;
}
