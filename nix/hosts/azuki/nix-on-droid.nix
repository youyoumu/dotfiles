{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
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
    delta
    just
    openssh
    gcc
    gnumake
    nixfmt-rfc-style
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
    inputs.nixpkgs-nixos-25-05.legacyPackages.aarch64-linux.neovim
    # luajitPackages.luarocks_bootstrap
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  nix.package = inputs.nixpkgs-nixos-25-05.legacyPackages.aarch64-linux.nix;
  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Jakarta";
}
