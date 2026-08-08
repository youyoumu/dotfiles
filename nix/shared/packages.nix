{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];
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
    xterm
    jq
    just
    lazydocker
    navi
    ripgrep
    sesh
    stow
    trash-cli
    tree
    unzip
    wget

    # Dev
    cargo
    clang-tools
    devenv
    difftastic
    gcc
    gnumake
    go
    kdlfmt
    lua
    luau
    luau-lsp
    lune
    nixd
    nixfmt
    nodejs
    pnpm
    python3
    ruby
    rustc
    stylua
    tree-sitter
    uv
    sqlite

    # System
    cloudflared
    cronie
    ffmpeg
    grub2
    libsecret
    lssecret
    ntfs3g
    xdg-utils

    # Inputs and Others
    inputs.fhs.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.lute.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nix-unit.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs = {
    bat.enable = true;
    fish.enable = true;
    git.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    starship.enable = true;
    tmux.enable = true;
    vim.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    nh.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        wayland
        libxkbcommon
        libGL
        icu
      ];
    };
    gnupg.agent.enable = true;
    firefox.enable = true;
    nix-index-database.comma.enable = true;
  };
}
