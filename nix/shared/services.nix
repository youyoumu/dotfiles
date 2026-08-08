{ ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    envfs.enable = true;
  };
}
