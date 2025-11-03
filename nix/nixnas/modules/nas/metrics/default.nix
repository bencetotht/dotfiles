{ ... }:
{
  services.prometheus.exporters = {
    node = {
      enable = true;
      port = 9100;
      # extraFlags = [
      #   "--collector.textfile.directory=/var/lib/node_exporter/textfile_collector"
      # ];
    };
    
    zfs = {
      enable = true;
      port = 9134;
    };

    smartctl = {
      enable = true;
      devices = [ "/dev/sda" "/dev/sdb" "/dev/sdc" "/dev/sdd" ];
      port = 9633;
    }
  };

  # systemd.services.snapraid-metrics = {
  #   description = "Export SnapRAID metrics for Prometheus";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''
  #       /bin/bash -c '
  #       snapraid status --json | jq -r "
  #         \"snapraid_scrub_percent \" + (.scrub.status.percent|tostring) + \"\n\" +
  #         \"snapraid_parity_errors \" + (.status.errors|tostring)
  #       " > /var/lib/node_exporter/textfile_collector/snapraid.prom
  #       '
  #     '';
  #   };
  # };

  # systemd.timers.snapraid-metrics = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnCalendar = "*:0/15"; # every 15 min
  #   };
  # };

}