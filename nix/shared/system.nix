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
      use-xdg-base-directories = true;
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
    # https://github.com/NixOS/nixpkgs/issues/149812
    sessionVariables.XDG_DATA_DIRS = [ "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}" ];
  };

}
