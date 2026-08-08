{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    amdgpu_top
    ollama
  ];
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/mnt/n1t-usagi2/chocola/var/lib/docker";
    };
  };
}
