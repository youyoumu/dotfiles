{
  config,
  pkgs,
  shared,
  ...
}:
let
  DOTFILES = "${config.home.homeDirectory}/dotfiles";
  CONFIG = "${DOTFILES}/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [ shared.nixosModules.dconf ];

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set __is_home_manager_config true
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
    ghostty = {
      enable = true;
      systemd.enable = true;
    };
  };

  home = {
    stateVersion = "25.05";
    file = {
      ".bash_logout".source = symlink "${DOTFILES}/.bash_logout";
      ".bash_profile".source = symlink "${DOTFILES}/.bash_profile";
      ".bashrc".source = symlink "${DOTFILES}/.bashrc";
      ".profile".source = symlink "${DOTFILES}/.profile";
      ".tmux.conf.local".source = symlink "${DOTFILES}/.tmux.conf.local";
      "hosts".source = symlink "${DOTFILES}/hosts";
      "scripts".source = symlink "${DOTFILES}/scripts";
    };
  };

  xdg.configFile = {
    "git".source = symlink "${CONFIG}/git";
    "ideavim".source = symlink "${CONFIG}/ideavim";
    "npm".source = symlink "${CONFIG}/npm";
    "bat".source = symlink "${CONFIG}/bat";
    "chezmoi".source = symlink "${CONFIG}/chezmoi";
    "delta".source = symlink "${CONFIG}/delta";
    "ghostty".source = symlink "${CONFIG}/ghostty";
    "hypr".source = symlink "${CONFIG}/hypr";
    "kitty".source = symlink "${CONFIG}/kitty";
    "lazygit".source = symlink "${CONFIG}/lazygit";
    "nano".source = symlink "${CONFIG}/nano";
    "niri".source = symlink "${CONFIG}/niri";
    "nvim".source = symlink "${CONFIG}/nvim";
    "vim".source = symlink "${CONFIG}/vim";
    "powershell".source = symlink "${CONFIG}/powershell";
    "rofi".source = symlink "${CONFIG}/rofi";
    "starship.toml".source = symlink "${CONFIG}/starship.toml";
    "swaync".source = symlink "${CONFIG}/swaync";
    "tmux".source = symlink "${CONFIG}/tmux";
    "walker".source = symlink "${CONFIG}/walker";
    "wireplumber".source = symlink "${CONFIG}/wireplumber";
    "wpaperd".source = symlink "${CONFIG}/wpaperd";
    "yazi".source = symlink "${CONFIG}/yazi";
    "zellij".source = symlink "${CONFIG}/zellij";
    "zvim".source = symlink "${CONFIG}/zvim";
    # partially managed by home-manager
    "fish/hosts".source = symlink "${CONFIG}/fish/hosts";
    "fish/init.fish".source = symlink "${CONFIG}/fish/init.fish";
    "environment.d/session.conf".source = symlink "${CONFIG}/environment.d/session.conf";
  };
}
