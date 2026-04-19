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
  specialisation = {
    withGnome.configuration = {
      services = {
        xserver.enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    envfs.enable = true;

    pipewire = {
      # enable = true;
      # alsa.enable = true;
      # alsa.support32Bit = true;
      # pulse.enable = true;
    };

    syncthing = {
      enable = true;
      user = "yym";
      dataDir = "/home/yym";
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "f14135e3-03af-4f23-9493-e4d0a169a232" = {
          credentialsFile = config.age.secrets."cloudflared.vanilla-tunnel.json".path;
          default = "http_status:404";
        };
      };
    };

    openssh = {
      enable = true;
      ports = [ 56789 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
        AcceptEnv = [ "SSH_PREFER_FISH" ];
      };
    };
  };

  security.rtkit.enable = true;
}
