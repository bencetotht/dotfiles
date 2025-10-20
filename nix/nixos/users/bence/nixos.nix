{ pkgs, inputs, ... }:

{
  # environment.pathsToLink = [ "/share/zsh" ];

  # environment.localBinInPath = true;

  programs.zsh.enable = true;

  users.users.bence = {
    isNormalUser = true;
    home = "/home/bence";
    extraGroups = [ "docker" "lxd" "wheel" "networkmanager"];
    shell = pkgs.zsh;
    hashedPassword = "$6$p5nPhz3G6k$6yCK0m3Oglcj4ZkUXwbjrG403LBZkfNwlhgrQAqOospGJXJZ27dI84CbIYBNsTgsoH650C1EBsbCKesSVPSpB1";
    # openssh.authorizedKeys.keys = [
    #   ""
    # ];
  };
}