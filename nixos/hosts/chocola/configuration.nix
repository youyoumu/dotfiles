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
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./disks.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

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
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  hardware.uinput.enable = true;

  networking.hostName = "chocola";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    Ethernet = {
      connection = {
        id = "Ethernet";
        type = "ethernet";
        interface-name = "enp5s0";
        autoconnect-priority = -999;
        uuid = "2f2c196e-9337-3fc7-957d-3a57694699ad";
        timestamp = "1751628497";
      };
      ethernet = { };
      ipv4 = {
        method = "manual";
        addresses = "192.168.1.100/24";
        gateway = "192.168.1.1";
        dns = "192.168.1.101";
      };
      ipv6 = {
        method = "auto";
        addr-gen-mode = "default";
      };
      proxy = { };
    };
  };

  networking.firewall.allowedTCPPorts = [
    56789
    8800
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  time.timeZone = "Asia/Jakarta";
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

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true; # enable Hyprland
  programs.niri.enable = true;

  systemd.tmpfiles.rules =
    let
      monitorsXmlContent = import ./monitors.xml.nix;
      monitorsXml = pkgs.writeText "monitors.xml" monitorsXmlContent;
    in
    [
      "L /run/gdm/.config/monitors.xml - - - - ${monitorsXml}"
    ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
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
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/mnt/SSD-1TB-128GB/chocola/var/lib/docker";
    };
  };
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

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    font-awesome
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      wayland
      libxkbcommon
      libGL
    ];
  };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
