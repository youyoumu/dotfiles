{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    # https://github.com/NixOS/nixpkgs/pull/514056
    # gst_all_1.gst-vaapi
  ];

  # environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = pkgs.lib.makeSearchPath "lib/gstreamer-1.0" [
  #   pkgs.gst_all_1.gstreamer
  #   pkgs.gst_all_1.gst-plugins-base
  #   pkgs.gst_all_1.gst-plugins-good
  #   pkgs.gst_all_1.gst-plugins-bad
  #   pkgs.gst_all_1.gst-plugins-ugly
  #   pkgs.gst_all_1.gst-libav
  #   pkgs.gst_all_1.gst-vaapi
  # ];

  environment.variables = {
    GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
  };
}
