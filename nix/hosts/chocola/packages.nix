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
    chezmoi
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
    tree
    tree
    unzip
    wget
    yazi
    zellij

    # Dev
    android-studio
    android-tools
    beekeeper-studio
    clang-tools
    deno
    devenv
    difftastic
    gcc
    gnumake
    go
    gradle
    jetbrains.idea
    kdlfmt
    kotlin
    neovide
    nixd
    nixfmt
    nodejs
    pnpm
    python3
    ruby
    rustup
    statix
    tree-sitter
    uv
    zulu

    # System
    amdgpu_top
    cloudflare-warp
    cloudflared
    cronie
    dpkg
    ffmpeg
    flatpak
    libsecret
    lssecret
    ollama
    pavucontrol
    pulseaudioFull
    sqlite
    syncthing
    xdg-utils

    # Desktop Environment
    adw-gtk3
    bibata-cursors
    cliphist
    file-roller
    grim
    hypridle
    hyprshot
    kdePackages.qt6ct
    libnotify
    mpv
    papirus-icon-theme
    satty
    slurp
    walker
    wl-clipboard
    xwayland-satellite

    # GUI Apps
    anki
    discord
    footage
    gimp3-with-plugins
    gnome-tweaks
    google-chrome
    handbrake
    kdePackages.kdenlive
    keepassxc
    kitty
    microsoft-edge
    mission-center
    obsidian
    qbittorrent
    shotcut
    spotify
    vlc

    # Gaming
    antimicrox
    bottles
    prismlauncher
    protonup-qt

    # Unsorted
    opencode

    # Inputs and Others
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    gnomeExtensions.vitals
    inputs.nix-alien.packages.${system}.nix-alien
    inputs.agenix.packages.${system}.default
    inputs.thorium.packages.${system}.thorium-avx2
    inputs.fhs.packages.${system}.default
    inputs.noctalia.packages.${system}.default
  ];
}
