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
    bat.enable = true;
    fish.enable = true;
    git.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    starship.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    yazi.enable = true;
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
