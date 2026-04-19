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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      #media-session.enable = true;
    };

    syncthing = {
      enable = true;
      user = "yym";
      dataDir = "/home/yym";
    };

    kmonad = {
      enable = true;
      keyboards = {
        laptop = {
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
          defcfg = {
            enable = true;
            fallthrough = true;
            allowCommands = false;
          };
          config = builtins.readFile ./kmonad.config.lisp;
        };
      };
    };
  };

  security.rtkit.enable = true;
  hardware.uinput.enable = true;
}
