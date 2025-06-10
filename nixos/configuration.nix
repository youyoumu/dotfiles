# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    theme = pkgs.catppuccin-grub;
    splashImage = null;
    configurationName = "yym";
    extraEntries = ''
      menuentry "Windows 11" {
        search --no-floppy --fs-uuid --set=root 58B1-0C54
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/HDD-1TB" = {
    device = "/dev/disk/by-uuid/2393FC547EB4A8F5";
    fsType = "auto";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
    ];
  };
  fileSystems."/mnt/SSD-1TB" = {
    device = "/dev/disk/by-uuid/6C0ACF540ACF19CA";
    fsType = "auto";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
    ];
  };
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  hardware.uinput.enable = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "chocola"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = "192.168.1.100";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.101" ];

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
    # ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true; # enable Hyprland
  programs.niri.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  #
  services.envfs.enable = true;
  services.syncthing = {
    enable = true;
    # openDefaultPorts = true; # Open ports in the firewall for Syncthing
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "76d5646b-569c-4604-a15f-0b7a02b06252" = {
        credentialsFile = "${config.users.users.yym.home}/.cloudflared/76d5646b-569c-4604-a15f-0b7a02b06252.json";
        default = "http_status:404";
      };
    };
  };
  services.openssh = {
    enable = true;
    ports = [ 56789 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  services.flatpak.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    56789
    8800
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yym = {
    isNormalUser = true;
    description = "youyoumu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "uinput"
    ];
    packages = [
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.nh = {
    enable = true;
    flake = "/home/yym/dotfiles/nixos";
    # clean.enable = true;
    # clean.extraArgs = "--keep-since 4d --keep 3";
  };
  virtualisation.docker.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.gpu-screen-recorder.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    fastfetch
    dconf-editor
    dconf2nix
    kitty
    stow
    tmux
    age
    fzf
    lazygit
    fish
    starship
    yazi
    eza
    zoxide
    navi
    sesh
    bat
    fd
    dust
    duf
    delta
    cronie
    syncthing
    gcc
    pyenv
    rbenv
    nodejs
    go
    ruby
    python3
    unzip
    luajitPackages.luarocks_bootstrap
    wget
    cargo
    zulu
    python312Packages.pip
    gnumake
    iosevka-bin
    pnpm
    fnm
    vscode
    nixfmt-rfc-style
    just
    dpkg
    mission-center
    google-chrome
    discord
    prismlauncher
    obsidian
    obs-studio
    anki-bin
    antimicrox
    handbrake
    qbittorrent
    keepassxc
    gimp3-with-plugins
    papirus-icon-theme
    shotcut
    vlc
    gnome-tweaks
    bibata-cursors
    waybar
    swaynotificationcenter
    hyprpaper
    hypridle
    hyprcursor
    hyprshot
    hyprlock
    rofi
    wl-clipboard
    libsecret
    lssecret
    neovide
    cloudflared
    lazydocker
    xdg-utils
    gnomeExtensions.vitals
    flatpak
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    kooha
    ripgrep
    pulseaudioFull
    pavucontrol
    kdePackages.qt6ct
    btop
    jq
    cliphist
    tree
    efibootmgr
    mpv
    walker
    libnotify
    xwayland-satellite
    slurp
    satty
    grim
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    font-awesome
  ];

  programs.nix-ld.enable = true;

  environment.variables.EDITOR = "nvim";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = pkgs.lib.mkForce (
    pkgs.lib.concatStringsSep ":" [
      "${pkgs.gst_all_1.gstreamer}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-vaapi}/lib/gstreamer-1.0"
    ]
  );

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
