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
  networking.hostName = "vanilla";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    Ethernet = {
      connection = {
        id = "Ethernet";
        type = "ethernet";
        interface-name = "enp3s0";
        uuid = "a01ed463-f18a-41e7-a9fa-fe784b8e4215";
      };
      ethernet = { };
      ipv4 = {
        method = "manual";
        addresses = "192.168.1.101/24";
        gateway = "192.168.1.1";
        dns = "1.1.1.1";
      };
      ipv6 = {
        method = "auto";
        addr-gen-mode = "default";
      };
      proxy = { };
    };
  };

  networking.firewall.allowedTCPPorts = [
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}
