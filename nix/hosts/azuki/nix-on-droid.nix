{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  environment = {
    packages = with pkgs; [
      nano
      which
      procps
      killall
      diffutils
      findutils
      utillinux
      tzdata
      hostname
      man
      gnugrep
      gnupg
      gnused
      gnutar
      bzip2
      gzip
      xz
      zip
      unzip
      gawk
      ncurses
      git
      fish
      zoxide
      eza
      fastfetch
      stow
      tmux
      age
      fzf
      lazygit
      fish
      starship
      yazi
      navi
      sesh
      bat
      fd
      dust
      duf
      just
      openssh
      gcc
      gnumake
      nixfmt
      nixd
      keychain
      curl
      ripgrep
      nodejs
      go
      ruby
      python3
      lua
      jq
      tree
      neovim
      difftastic
    ];

    etcBackupExtension = ".bak";

    sessionVariables = {
      HOSTNAME = "azuki";
    };
  };

  time.timeZone = "Asia/Jakarta";

  user.userName = "yym";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  terminal.font = "${pkgs.nerd-fonts.iosevka}/share/fonts/truetype/NerdFonts/Iosevka/IosevkaNerdFontMono-Regular.ttf";
  terminal.colors = {
    background = "#1e1e2e";
    foreground = "#cdd6f4";
    cursor = "#cdd6f4";

    color0 = "#45475a";
    color1 = "#f38ba8";
    color2 = "#a6e3a1";
    color3 = "#f9e2af";
    color4 = "#89b4fa";
    color5 = "#f5c2e7";
    color6 = "#94e2d5";
    color7 = "#bac2de";
    color8 = "#585b70";
    color9 = "#f38ba8";
    color10 = "#a6e3a1";
    color11 = "#f9e2af";
    color12 = "#89b4fa";
    color13 = "#f5c2e7";
    color14 = "#94e2d5";
    color15 = "#a6adc8";
  };
}
