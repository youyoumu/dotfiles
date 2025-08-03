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
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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
    user = "yym";
    dataDir = "/home/yym"; # default location for new folders
    # openDefaultPorts = true; # Open ports in the firewall for Syncthing
  };
  services.flatpak.enable = true;
}
