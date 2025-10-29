{ config, builtins, ... }:
let
  diskMain = builtins.head config.zfs-root.bootDevices;
in
{
  disko.devices = {
    disk = {
      # SSD128 - 1
      sda = {
        device = "/dev/disk/by-id/ata-Patriot_P210_128GB_P210HHBB250407015510";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            EFI = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
              mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
      # SSD128 - 2
      sdb = {
        device = "/dev/disk/by-id/ata-Patriot_P210_128GB_P210HHBB250407015547";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            EFI = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
              # Avoid conflict with the primary ESP; keep a secondary copy mounted separately
              mountpoint = "/boot2";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };

    zpool = {
      rpool = {
        type = "zpool";
        mode = "mirror";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          acltype = "posixacl";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          normalization = "formD";
          relatime = "on";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };
        mountpoint = "/";
        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options = {
              compression = "lz4";
            };
          };
          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "home" = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          "var" = {
            type = "zfs_fs";
            mountpoint = "/var";
          };
        };
      };
    };
  };
}