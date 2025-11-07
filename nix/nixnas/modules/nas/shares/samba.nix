{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    samba4Full
  ];

  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
    openFirewall = true; # allow samba to be accessed from the internet

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "NIXNAS";
        "server min protocol" = "SMB3";
        "security" = "user";
        "map to guest" = "Bad User";
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:aapl" = "yes";
        "fruit:model" = "TimeMachineNAS";
        "fruit:metadata" = "stream";
        "fruit:time machine" = "yes";
      };
    };

    shares = {
      "timemachine" = {
        path = "/mnt/w3storage/tmbackup";
        browseable = "yes";
        writeable = "yes";
        "valid users" = [ "tmuser" ];
        "fruit:time machine" = "yes";
        "fruit:time machine max size" = "500G";
      };
    };
  };
}