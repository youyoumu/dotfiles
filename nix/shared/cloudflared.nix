{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.cloudflared;
in
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  options.services.cloudflared.tunnelNames = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config.services.cloudflared = {
    enable = cfg.tunnelNames != [ ];
    tunnels = {
      "76d5646b-569c-4604-a15f-0b7a02b06252" = lib.mkIf (builtins.elem "chocola-tunnel" cfg.tunnelNames) {
        credentialsFile = config.age.secrets."cloudflared.chocola-tunnel.json".path;
        default = "http_status:404";
      };
      "f14135e3-03af-4f23-9493-e4d0a169a232" = lib.mkIf (builtins.elem "vanilla-tunnel" cfg.tunnelNames) {
        credentialsFile = config.age.secrets."cloudflared.vanilla-tunnel.json".path;
        default = "http_status:404";
      };
    };
  };

  config.environment.systemPackages = [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
