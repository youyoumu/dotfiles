{
  lib,
  config,
  options,
  pkgs,
  inputs,
  system,
  ...
}:
{
  networking = {
    hostName = "coconut";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
    ];
  };
}
