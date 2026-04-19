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
    niri = {
      enable = true;
      useNautilus = true;
    };
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
        icu
      ];
    };
    gnupg.agent.enable = true;
    bat.enable = true;
    fish.enable = true;
    git.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    neovim.enable = true;
    vscode.enable = true;
    vim.enable = true;
    firefox.enable = true;
    obs-studio.enable = true;
    zoom-us.enable = true;
    gpu-screen-recorder.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/mnt/WarmBrew265G/chocola/var/lib/docker";
    };
  };
}
