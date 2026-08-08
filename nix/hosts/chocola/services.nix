{ inputs, ... }:
{
  imports = [
    inputs.nix-secrets.nixosModules.chocola
  ];

  services.cloudflared.tunnelNames = [ "chocola-tunnel" ];
}
