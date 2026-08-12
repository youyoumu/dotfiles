{
  nixosModules = {
    system = ./system.nix;
    packages = {
      default = ./packages.nix;
      desktop = ./packages.desktop.nix;
      toolchain = ./packages.toolchain.nix;
    };
    services = {
      default = ./services.nix;
      desktop = ./services.desktop.nix;
      openssh = ./services.openssh.nix;
      cloudflared = ./cloudflared.nix;
    };
    home-manager = {
      default = ./home-manager.nix;
      desktop = ./home-manager.desktop.nix;
    };
    user.yym = ./users.yym.nix;
    fonts = ./fonts.nix;
    ime = ./ime.nix;
    dconf = ./dconf.nix;
    gstreamer = ./gstreamer.nix;
    systemd = {
      sync-gdm-monitors = ./systemd.sync-gdm-monitors.nix;
    };
    boot = {
      grub = ./boot.grub.nix;
    };
  };
  util = import ./util.nix;
}
