{ config, pkgs, ... }:
{
  imports = [ ./dconf.nix ];
  home.packages = with pkgs; [

  ];

  xdg.desktopEntries.discord = {
    name = "Discord";
    genericName = "All-in-one cross-platform voice and text chat for gamers";
    exec = "discord --ozone-playform-hint=auto --enable-wayland-ime --wayland-text-input-version=3";
    icon = "discord";
    type = "Application";
    mimeType = [ "x-scheme-handler/discord" ];
    categories = [
      "Network"
      "InstantMessaging"
    ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  dconf.settings = {

  };

}
