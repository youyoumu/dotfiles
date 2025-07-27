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
      services.xserver.enable = true;
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    # enable = true;
    # alsa.enable = true;
    # alsa.support32Bit = true;
    # pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.envfs.enable = true;
  services.syncthing = {
    enable = true;
    user = "yym";
    dataDir = "/home/yym"; # default location for new folders
    # openDefaultPorts = true; # Open ports in the firewall for Syncthing
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "f14135e3-03af-4f23-9493-e4d0a169a232" = {
        credentialsFile =
          config.age.secrets."vanilla.cloudfalred.f14135e3-03af-4f23-9493-e4d0a169a232.json".path;
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
      AcceptEnv = "SSH_PREFER_FISH";
    };
  };
}
