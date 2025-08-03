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
    ];
  };
  virtualisation.docker = {
    enable = true;
    # daemon.settings = {
    #   data-root = "/mnt/SSD-1TB-128GB/chocola/var/lib/docker";
    # };
  };
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.firefox.enable = true;
}
