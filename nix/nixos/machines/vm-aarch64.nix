{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware/vm-aarch64.nix
    ./vm-shared.nix
  ];

  boot.binfmt.emulatedSystems = ["x86_64-linux"];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "0";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos-graphical-25.05-aarch64";
    fsType = "ext4";
  };

  # ens160 is the default interface for vmware fusion
  networking.interfaces.ens160.useDHCP = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  virtualisation.vmware.guest.enable = true;

  # Share our host filesystem
  # fileSystems."/host" = {
  #   fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
  #   device = ".host:/";
  #   options = [
  #     "umask=22"
  #     "uid=1000"
  #     "gid=1000"
  #     "allow_other"
  #     "auto_unmount"
  #     "defaults"
  #   ];
  # };
}
