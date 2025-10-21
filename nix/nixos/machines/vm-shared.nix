{ config, pkgs, lib, currentSystem, currentSystemName, ... }:

{
  imports = [
    # ../modules/specialization/plasma.nix
    # ../modules/specialization/i3.nix
    # ../modules/specialization/gnome-ibus.nix
  ];

  # Be careful updating this.
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config.permittedInsecurePackages = [
    "mupdf-1.17.0"
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "nixvm";

  time.timeZone = "Europe/Budapest";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  networking.useDHCP = false;

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.lxd = {
    enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-gtk
        fcitx5-hangul
        fcitx5-mozc
      ];
    };
    extraLocaleSettings = {
      LC_ADDRESS = "hu_HU.UTF-8";
      LC_IDENTIFICATION = "hu_HU.UTF-8";
      LC_MEASUREMENT = "hu_HU.UTF-8";
      LC_MONETARY = "hu_HU.UTF-8";
      LC_NAME = "hu_HU.UTF-8";
      LC_NUMERIC = "hu_HU.UTF-8";
      LC_PAPER = "hu_HU.UTF-8";
      LC_TELEPHONE = "hu_HU.UTF-8";
      LC_TIME = "hu_HU.UTF-8";
    };
  };

  console.keyMap = "hu";

  services.tailscale.enable = true;

  # Define a user account
  users.mutableUsers = false;

  # fonts
  # fonts = {
  #   fontDir.enable = true;

  #   packages = [
  #     pkgs.fira-code
  #     pkgs.jetbrains-mono
  #   ];
  # };

  # List packages installed in system profile. To search, run: nix search wget
#   environment.systemPackages = with pkgs; [
#     cachix
#     gnumake
#     killall
#     xclip
#
#     # For hypervisors that support auto-resizing, this script forces it.
#     (writeShellScriptBin "xrandr-auto" ''
#       xrandr --output Virtual-1 --auto
#     '')
#   ] ++ lib.optionals (currentSystemName == "vm-aarch64") [
#     # vmware user tools clipboard
#     gtkmm3
#   ];

  # desktop environment.
  # x11 - we will nuke it later
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+i3";
  # services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bence";

  # security.pam.services = {
  #   i3lock.enable = true;
  #   i3lock-color.enable = true;
  #   xlock.enable = true;
  #   xscreensaver.enable = true;
  # };


  environment.systemPackages = with pkgs; [
    vim
    wget
    gh
    git
    lazygit
    i3status
    dmenu
    feh
    picom
  ];


#   services.xserver = lib.mkIf (config.specialisation != {}) {
#     enable = true;
#     xkb.layout = "hu";
#     desktopManager.gnome.enable = true;
#     displayManager.gdm.enable = true;
#   };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  # Enable flatpak
  # services.flatpak.enable = true;

  # Enable snap
  # services.snap.enable = true;

  # Disable the firewall
  networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
