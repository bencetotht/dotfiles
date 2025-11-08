{ inputs, pkgs, ... }:

{
  # Brew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # this removes all cached downloads, set it to "disabled" to keep them

    casks  = [
      "1password"
      "claude"
      "cleanshot"
      "discord"
      "fantastical"
      "google-chrome"
      "hammerspoon"
      "imageoptim"
      "istat-menus"
      "monodraw"
      "raycast"
      "rectangle"
      "screenflow"
      "slack"
      "spotify"
    ];

    brews = [
      "gnupg"
    ];
  };

  # System settings
  system.defaults = {
    dock.autohide = false;
  };
  
  # User settings
  users.users.bence = {
    home = "/Users/bence";
    shell = pkgs.zsh;
  };

  system.primaryUser = "bence";
}
