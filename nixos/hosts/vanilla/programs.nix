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
  programs.nh = {
    enable = true;
    flake = "/home/yym/dotfiles/nixos";
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
  };
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.firefox.enable = true;
}
