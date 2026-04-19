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
  programs = {
    nh = {
      enable = true;
      flake = "/home/yym/dotfiles/nix";
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        wayland
        libxkbcommon
        libGL
      ];
    };
    gnupg.agent = {
      enable = true;
    };
    firefox.enable = true;
  };

  virtualisation.docker = {
    enable = true;
  };
}
