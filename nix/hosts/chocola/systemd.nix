{ config, pkgs, ... }:
{
  systemd.services.applyUserMonitorSettings =
    let
      username = "yym";
      gdmConfigDir = "/var/lib/gdm/seat0/config";
      applyScript = pkgs.writeShellScript "apply-monitor-settings" ''
        echo "Applying user monitor settings to GDM login screen"
        # 1. Ensure the directory exists
        mkdir -p ${gdmConfigDir}
        # 2. Remove existing file or dangling symlinks to avoid 'cp' errors
        rm -f ${gdmConfigDir}/monitors.xml
        # 3. Perform the copy if the source exists
        if [ -f "/home/${username}/.config/monitors.xml" ]; then
            cp /home/${username}/.config/monitors.xml ${gdmConfigDir}/monitors.xml
            chown gdm:gdm ${gdmConfigDir}/monitors.xml
            echo "Successfully copied and set permissions for monitors.xml"
        else
            echo "Error: Source monitors.xml not found in /home/${username}/.config/"
            exit 1
        fi
      '';
    in
    {
      description = "Apply user monitor settings to GDM login screen";
      after = [
        "network.target"
        "systemd-user-sessions.service"
        "display-manager.service"
      ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${applyScript}";
      };
    };
}
