{
  pkgs,
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # CLI & Shell
    age
    bat
    btop
    duf
    dust
    eza
    fastfetch
    fd
    fish
    fzf
    git
    jq
    just
    lazygit
    lazydocker
    navi
    neovim
    ripgrep
    sesh
    starship
    stow
    tmux
    wget
    yazi
    zoxide

    # Dev
    cargo
    difftastic
    gcc
    gnumake
    go
    isd
    keychain
    nixd
    nixfmt
    nodejs
    pm2
    pnpm
    python3
    python312Packages.pip
    ruby
    rcon-cli
    systemd-lsp
    unzip
    zulu

    # System
    cloudflared
    cronie
    syncthing

    # GUI Apps
    keepassxc
    kitty

    # Inputs and Others
    inputs.nix-alien.packages.${system}.nix-alien
    inputs.agenix.packages.${system}.default
    inputs.fhs.packages.${system}.default
  ];
}
