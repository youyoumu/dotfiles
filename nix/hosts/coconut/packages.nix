{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cowsay
  ];
  virtualisation.docker.enable = true;
}
