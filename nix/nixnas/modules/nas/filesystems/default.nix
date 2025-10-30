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

  fileSystems."/mnt/w3d3" = {
    device = "/dev/disk/by-label/w3d3";
    fsType = "ext4";
  };
  fileSystems."/mnt/w3d4" = {
    device = "/dev/disk/by-label/w3d4";
    fsType = "ext4";
  };
}