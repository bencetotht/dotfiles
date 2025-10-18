{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;
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

  users.users.bence = {
    home = "/home/bence";
    shell = pkgs.zsh;
  };

  system.primaryUser = "bence";
}