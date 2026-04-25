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
    btop
    duf
    dust
    eza
    fastfetch
    fd
    fzf
    jq
    just
    lazydocker
    navi
    ripgrep
    sesh
    stow
    trash-cli
    wget

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
    ollama-cpu

    # GUI Apps
    keepassxc
    kitty

    # Inputs and Others
    inputs.nix-alien.packages.${system}.nix-alien
    inputs.agenix.packages.${system}.default
    inputs.fhs.packages.${system}.default
  ];
}
