{ pkgs, ... }: {
  # Map config files
  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "i3status/config".text = builtins.readFile ./i3status.conf;
  };

  # Configure i3
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      gaps = {
        inner = 10;
        outer = 5;
      };
      terminal = "ghostty";
    };
  };

}