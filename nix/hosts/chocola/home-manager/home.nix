{
  config,
  pkgs,
  shared,
  ...
}:
let
  DOTFILES = "/home/yym/dotfiles";
  FISH = "${DOTFILES}/.config/fish";
  symLink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [ shared.dconf ];
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set is_home_manager true
        source ~/.config/fish/init.fish
      '';
      plugins = [
        {
          name = "z";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "0069dbbe06cc05482bfb13063b4b4eac26318992";
            sha256 = "sha256-H7HgYT+okuVXo2SinrSs+hxAKCn4Q4su7oMbebKd/7s=";
          };
        }
      ];
    };
    fzf.enable = true;
    zoxide.enable = true;
    navi.enable = true;
    starship.enable = true;
    ghostty.systemd.enable = true;
  };

  home = {
    file = {
      ".config/fish/init.fish".source = symLink "${FISH}/init.fish";
      ".config/fish/hosts".source = symLink "${FISH}/hosts";
    };
    # packages = with pkgs; [ ];
  };

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
}
