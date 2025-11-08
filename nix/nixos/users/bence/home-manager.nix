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
  home.username = "bence";
  # home.homeDirectory = "/home/bence";

  # home.sessionVariables = {
  #   LANG = "en_US.UTF-8";
  #   LC_CTYPE = "en_US.UTF-8";
  #   LC_ALL = "en_US.UTF-8";
  #   EDITOR = "nvim";
  # };

  programs.zsh = {
    enable = true;
    shellAliases = shellAliases;
    ohMyZsh = {
    enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    };
  };

  programs.ghostty.enable = true;

  home.stateVersion = "25.05";
}
