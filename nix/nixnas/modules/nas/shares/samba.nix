{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    samba4Full
  ];

  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
    openFirewall = true; # allow samba to be accessed from the internet

    extraConfig = ''
      server min protocol = SMB3
      vfs objects = fruit streams_xattr
      fruit:metadata = stream
      fruit:resource = file
      fruit:time machine = yes
      fruit:locking = none
      fruit:encoding = native
    '';

    shares = {
      "timemachine" = {
        path = "/mnt/w3storage/tmbackup";
        browseable = "yes";
        writeable = "yes";
        "valid users" = "tmuser";
        "fruit:time machine" = "yes";
      };
    };
  };
}