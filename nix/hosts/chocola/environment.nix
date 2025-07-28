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
  environment.variables.EDITOR = "nvim";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = pkgs.lib.mkForce (
    pkgs.lib.concatStringsSep ":" [
      "${pkgs.gst_all_1.gstreamer}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0"
      "${pkgs.gst_all_1.gst-vaapi}/lib/gstreamer-1.0"
    ]
  );
}
