{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  environment.shellAliases = {
    nshell = "nix-shell --run $SHELL"
  };

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" ];
    custom = "$HOME/.oh-my-zsh/custom/";
    theme = "robbyrussell";
  };


}
