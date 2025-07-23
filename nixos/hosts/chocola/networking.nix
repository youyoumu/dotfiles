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
  networking.hostName = "chocola";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    Ethernet = {
      connection = {
        id = "Ethernet";
        type = "ethernet";
        interface-name = "enp5s0";
        autoconnect-priority = -999;
        uuid = "2f2c196e-9337-3fc7-957d-3a57694699ad";
        timestamp = "1751628497";
      };
      ethernet = { };
      ipv4 = {
        method = "manual";
        addresses = "192.168.1.100/24";
        gateway = "192.168.1.1";
        dns = "192.168.1.101";
      };
      ipv6 = {
        method = "auto";
        addr-gen-mode = "default";
      };
      proxy = { };
    };
  };

  networking.firewall.allowedTCPPorts = [
    56789
    8800
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}
