{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  environment.systemPackages = with pkgs; [
    # Dev
    android-tools

    # System
    antimicrox
    cliphist
    cloudflare-warp
    ffmpeg-headless
    ffmpegthumbnailer
    file-roller
    gdk-pixbuf
    libnotify
    papirus-icon-theme
    pavucontrol
    pulseaudioFull
    satty
    wl-clipboard
    xwayland-satellite

    # GUI Apps
    anki
    discord
    footage
    ghostty
    gnome-tweaks
    google-chrome
    handbrake
    microsoft-edge
    obsidian
    prismlauncher
    qbittorrent
    shotcut
    vlc

    # Inputs and Others
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.thorium-avx2
  ];
  programs = {
    niri = {
      enable = true;
      useNautilus = true;
    };
    noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
    vscode.enable = true;
    gpu-screen-recorder.enable = true;
    obs-studio.enable = true;
  };
}
