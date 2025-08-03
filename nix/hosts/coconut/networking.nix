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
  networking.hostName = "coconut";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}
