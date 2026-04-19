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
    flatpak.enable = true;
    cloudflare-warp.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    syncthing = {
      enable = true;
      user = "yym";
      dataDir = "/home/yym";
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "76d5646b-569c-4604-a15f-0b7a02b06252" = {
          credentialsFile = config.age.secrets."cloudflared.chocola-tunnel.json".path;
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
