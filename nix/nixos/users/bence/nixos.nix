{ pkgs, inputs, ... }:

{
  imports = [
    ../modules/i3
  ];
  # environment.pathsToLink = [ "/share/zsh" ];

  # environment.localBinInPath = true;

  home.packages = [
    pkgs.xfce.xfce4-terminal
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.rofi
    pkgs.firefox
  ];

  programs.zsh.enable = true;

  users.users.bence = {
    isNormalUser = true;
    description = "Bence Toth";
    home = "/home/bence";
    extraGroups = [ "docker" "lxd" "wheel" "networkmanager"];
    shell = pkgs.zsh;
    # mkpasswd -m sha-512 password
    hashedPassword = "$6$pIsEjWjJ5M46WA1c$G8daVmgyAy2fJ62t/ceDkMWSqBVRMPVJS5j2a3q5dvEzOYplV6DYpLNxb7tjgAM9QRC7f2Y09YRbAmJCLMOMs1";
    # openssh.authorizedKeys.keys = [
    #   ""
    # ];
  };

  home.pointerCursor = lib.mkIf (isLinux) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
