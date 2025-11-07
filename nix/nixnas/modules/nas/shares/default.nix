{ ... }:
{
  imports = [
    ./samba.nix
  ];

  users.users.tmuser = {
    isSystemUser = true;
    home = "/mnt/w3storage/tmbackup";
    createHome = true;
    group = "tmusers";
  };

  users.groups.tmusers = {};
}