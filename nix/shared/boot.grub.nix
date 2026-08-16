{
  config,
  lib,
  pkgs,
  ...
}:
let
  rebootToNext = pkgs.writeShellScriptBin "reboot-to-next" ''
    set -e
    case "''${1:-}" in
      -h|--help)
        echo "usage: reboot-to-next <grub-entry>"
        echo "reboots the system, booting into the given grub entry next time"
        exit 0
        ;;
    esac
    entry="''${1:?usage: reboot-to-next <grub-entry>}"
    ${lib.getExe' pkgs.grub2 "grub-editenv"} /boot/grub/grubenv set "next_entry=$entry"
    exec ${lib.getExe' config.systemd.package "systemctl"} reboot
  '';
in
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        default = "saved";
        theme = pkgs.catppuccin-grub;
        splashImage = null;
        configurationName = "yym";
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };

  environment.systemPackages = [ rebootToNext ];

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/reboot-to-next";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}