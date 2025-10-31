{ ... }:
{
  services.snapraid = {
    enable = true;
    parityFiles = [
      "/mnt/w3d4/snapraid.parity"
    ];

    contentFiles = [
      "/mnt/w3d3/snapraid.content"
      "/mnt/w3d4/snapraid.content"
    ];

    dataDisks = {
      "w3d3" = "/mnt/w3d3";
    };

    exclude = [
      "*.tmp"
      "/lost+found/"
      "/.Trash-*/"
    ];

    touchBeforeSync = true;

    sync.interval = "daily";
    scrub.interval = "weekly";
  };

  # systemd.services.snapraid-sync = {
  #   description = "SnapRAID Sync";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.snapraid}/bin/snapraid sync";
  #   };
  # };

  # systemd.timers.snapraid-sync = {
  #   description = "Daily SnapRAID Sync";
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnCalendar = "daily";
  #     Persistent = true;
  #   };
  # };

  # systemd.services.snapraid-scrub = {
  #   description = "SnapRAID Scrub";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.snapraid}/bin/snapraid scrub -p 10 -o 7";
  #   };
  # };

  # systemd.timers.snapraid-scrub = {
  #   description = "Weekly SnapRAID Scrub";
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnCalendar = "weekly";
  #     Persistent = true;
  #   };
  # };
}