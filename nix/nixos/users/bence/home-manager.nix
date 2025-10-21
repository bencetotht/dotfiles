{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  shellAliases = {
    lg = "lazygit";
  } // (if isLinux then {
    pbcopy = "xclip";
    pbpaste = "xclip -o";
  } else {});

in {
  # imports = [ ./neovim.nix ];

  home.username = "bence";
  home.homeDirectory = "/home/bence";

  home.packages = [
    pkgs.xfce.xfce4-terminal
    pkgs.eza
    pkgs.fd
    pkgs.fzf
  ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
  };

  # home.sessionVariables = {
  #   LANG = "en_US.UTF-8";
  #   LC_CTYPE = "en_US.UTF-8";
  #   LC_ALL = "en_US.UTF-8";
  #   EDITOR = "nvim";
  # };

  programs.zsh = {
    enable = true;
    shellAliases = shellAliases;
  };

  programs.ghostty.enable = true;

  # home.pointerCursor = lib.mkIf (isLinux) {
  #   name = "Vanilla-DMZ";
  #   package = pkgs.vanilla-dmz;
  #   size = 128;
  #   x11.enable = true;
  # };

  home.stateVersion = "25.05";
}
