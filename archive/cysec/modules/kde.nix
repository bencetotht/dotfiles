{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.etc."xdg/kdeglobals".text = ''
    [General]
    ColorScheme=BreezeLight
    Name=Minimal
    singleClick=false

    [KDE]
    AnimationDurationFactor=0
    LookAndFeelPackage=org.kde.breezelight.desktop
    ShowDeleteCommand=false
  '';

  environment.etc."xdg/plasmarc".text = ''
    [Theme]
    name=BreezeLight

    [PlasmaViews][Panel 2]
    lengthMode=Fill

    [PlasmaViews][Panel 2][General]
    opacity=0.9

    [Containments][1][General]
    showToolTips=false
    enableAnimations=false
    showDesktopIcons=false
  '';
}