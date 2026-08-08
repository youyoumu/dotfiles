{ ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    flatpak.enable = true;
    cloudflare-warp.enable = true;

    printing.enable = true;
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  # paired with PipeWire to prevent audio crackling, dropouts, and latency issues.
  security.rtkit.enable = true;
}
