{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    mergerfs
    mergerfs-tools
    snapraid
    parted
    xfsprogs
    gptfdisk
  ];

  # fixing mergerfs permission issues
  # boot.initrd.systemd.enable = true;

  # Disk definitions
  fileSystems."/mnt/w3d3" = {
    device = "/dev/disk/by-label/w3d3";
    fsType = "ext4";
  };
  fileSystems."/mnt/w3d4" = {
    device = "/dev/disk/by-label/w3d4";
    fsType = "ext4";
  };

  # Mergerfs
  fileSystems."/mnt/w3storage" = {
    device = "/mnt/w3d3:/mnt/w3d4";
    fsType = "fuse.mergerfs";
    options = [
      "defaults"
      "allow_other"
      "use_ino"
      "category.create=mfs"
      "moveonenospc=true"
    ];
  };
}