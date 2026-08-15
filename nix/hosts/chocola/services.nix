{ inputs, ... }:
{
  imports = [
    inputs.nix-secrets.nixosModules.chocola
  ];

  services.cloudflared.tunnelNames = [ "chocola-tunnel" ];

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/mnt/n1t-usagi2/chocola/var/lib/docker";
    };
  };
  systemd.services.docker.unitConfig.RequiresMountsFor = "/mnt/n1t-usagi2";
}
