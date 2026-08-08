{ inputs, pkgs, ... }:
{

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "yym"
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.yym = {
    isNormalUser = true;
    description = "youyoumu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "uinput"
      "adbuser"
    ];
  };

  hardware = {
    keyboard.qmk.enable = true;
    uinput.enable = true;
  };

  environment = {
    variables.EDITOR = "nvim";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ANKI_WAYLAND = "1";
      # https://github.com/NixOS/nixpkgs/issues/149812
      XDG_DATA_DIRS = [ "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}" ];
    };
  };

}
