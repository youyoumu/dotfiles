{ ... }:
{
  services = {
    openssh = {
      enable = true;
      ports = [ 56789 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
        PermitUserEnvironment = "SSH_PREFER_FISH";
      };
    };
  };
}
