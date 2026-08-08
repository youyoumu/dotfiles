{ pkgs, ... }:
{
  systemd.services.sync-gdm-monitors =
    let
      username = "yym";
      userMonitors = "/home/${username}/.config/monitors.xml";
      gdmConfigDir = "/var/lib/gdm/seat0/config";
    in
    {
      description = "Sync user monitor layout to GDM login screen";
      before = [ "display-manager.service" ];
      after = [ "local-fs.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "sync-gdm-monitors" ''
          if [ -f "${userMonitors}" ]; then
              mkdir -p "${gdmConfigDir}"
              cp -f "${userMonitors}" "${gdmConfigDir}/monitors.xml"
              chown gdm:gdm "${gdmConfigDir}/monitors.xml"
              chmod 644 "${gdmConfigDir}/monitors.xml"
              echo "Successfully copied and set permissions for monitors.xml"
          else
              echo "Warning: ${userMonitors} not found, skipping sync."
          fi
        '';
      };
    };
}
