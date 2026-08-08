{ ... }:
{
  networking = {
    hostName = "coconut";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
    ];
  };
}
