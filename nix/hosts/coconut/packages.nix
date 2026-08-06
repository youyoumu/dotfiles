{
  pkgs,
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # CLI & Shell
    age
    btop
    duf
    dust
    eza
    fastfetch
    fd
    fzf
    jq
    just
    lazydocker
    navi
    ripgrep
    sesh
    stow
    trash-cli
    wget

    # Dev
    cargo
    difftastic
    gcc
    gnumake
    go
    kdlfmt
    neovide
    nixd
    nixfmt
    nodejs
    pnpm
    python3
    ruby
    statix

    # System
    cloudflared
    cronie
    flatpak
    ffmpeg
    libsecret
    lssecret
    pulseaudioFull
    unzip
    xdg-utils

    # Desktop Environment
    adw-gtk3
    bibata-cursors
    cliphist
    grim
    hyprcursor
    hypridle
    hyprpaper
    hyprshot
    kdePackages.qt6ct
    kooha
    libnotify
    mpv
    papirus-icon-theme
    pavucontrol
    satty
    slurp
    walker
    wl-clipboard
    xwayland-satellite

    # GUI Apps
    anki
    discord
    gimp3-with-plugins
    gnome-tweaks
    google-chrome
    handbrake
    kitty
    microsoft-edge
    mission-center
    obsidian
    qbittorrent
    shotcut
    vlc

    # Gaming
    antimicrox
    prismlauncher

    # Inputs and Others
    gnomeExtensions.vitals
    inputs.thorium.packages.${system}.thorium-avx2
    inputs.fhs.packages.${system}.default
  ];
}
