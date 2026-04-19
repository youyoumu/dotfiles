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
    bat
    btop
    duf
    dust
    eza
    fastfetch
    fd
    fish
    fzf
    git
    jq
    just
    lazydocker
    lazygit
    navi
    neovim
    ripgrep
    sesh
    starship
    stow
    tmux
    vim
    wget
    yazi
    zoxide

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
    vscode

    # System
    cloudflared
    cronie
    flatpak
    ffmpeg
    libsecret
    lssecret
    pulseaudioFull
    syncthing
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
    keepassxc
    kitty
    microsoft-edge
    mission-center
    obsidian
    obs-studio
    qbittorrent
    shotcut
    spotify
    vlc

    # Gaming
    antimicrox
    prismlauncher

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
    inputs.thorium.packages.${system}.thorium-avx2
    inputs.fhs.packages.${system}.default
    inputs.noctalia.packages.${system}.default
  ];
}
