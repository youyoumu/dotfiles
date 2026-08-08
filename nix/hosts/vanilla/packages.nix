{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    isd
    keychain
    rcon-cli
    ollama-cpu
  ];
  virtualisation.docker.enable = true;
}
