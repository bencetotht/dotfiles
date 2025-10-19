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
  };

  programs.zsh.enable = true;
  # programs.zsh.shellInit = ''
  #   # Nix
  #   if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  #     . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  #   fi
  #   # End Nix
  #   '';

  # environment.shells = with pkgs; [ bashInteractive zsh ];
  # environment.systemPackages = with pkgs; [
  #   cachix
  #   neovim
  #   git
  # ];
}