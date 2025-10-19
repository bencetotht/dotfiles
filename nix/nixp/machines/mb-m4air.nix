{ config, pkgs, ... }: {
  system.stateVersion = 5; # macOS Sequoia

  ids.gids.nixbld = 30000;

  nixpkgs.config.allowUnfree = true;

  nix = {
    enable = false;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    # Linux-builder for building Linux packages on our Mac.
    # linux-builder = {
    #   enable = false;
    #   ephemeral = true;
    #   maxJobs = 4;
    #   config = ({ pkgs, ... }: {
    #     # Make our builder beefier since we're on a beefy machine.
    #     virtualisation = {
    #       cores = 6;
    #       darwin-builder = {
    #         diskSize = 100 * 1024; # 100GB
    #         memorySize = 32 * 1024; # 32GB
    #       };
    #     };

    #     # Add some common debugging tools we can see whats up.
    #     environment.systemPackages = [
    #       pkgs.htop
    #     ];
    #   });
    # };

  };

  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
    '';

  environment.shells = with pkgs; [ bashInteractive zsh ];
  environment.systemPackages = with pkgs; [
    cachix
    neovim
    git
  ];
}