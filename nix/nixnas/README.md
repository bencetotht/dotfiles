# NixNas Flake

This Nix Flake is my home server setup with mirrored zfs boot drives. 

## Install steps
- After fetching the flake, use the following command to partition the disks using disko:
```bash
nix run github:nix-community/disko -- --mode disko --flake .#nas
```
- Check the success of installation:
```bash
mount | grep /mnt
zpool status
```
- Install the flake to the system:
```bash
nixos-install --flake .#nas
```
- Reboot the system

After installation, you can rebuild the system with the following command:
```bash
nixos-rebuild switch --flake .#nas
```

## Resources
Some useful resources, if you want to follow these steps manually:
- https://ipetkov.dev/blog/installing-nixos-and-zfs-on-my-desktop/
- https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS.html