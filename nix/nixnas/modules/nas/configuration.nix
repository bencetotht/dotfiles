{ config, lib, pkgs, ...}:

{
  # Enable flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Set the boot to support zfs
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        # device = "nodev";
        mirroredBoots = [
          { devices = ["nodev"]; path = "/boot"; efiSysMountPoint="/boot"; }
          { devices = ["nodev"]; path = "/boot2"; efiSysMountPoint="/boot2"; }
        ];
      };
    };
    supportedFilesystems = [ "zfs" ];
    kernelModules = [ "zfs" ];
  };

  # Network settings
  networking = {
    useDHCP = false;
    networkmanager.enable = false;
    nameservers = [ "1.1.1.1" ];
    defaultGateway = "192.168.50.1";
    hostName = "nixnas";
    hostId = "3f9c7a2b";
    interfaces.eno1 = {
      ipv4.addresses = [
        {
          address = "192.168.50.65";
          prefixLength = 24;
        }
      ];
      ipv4.routes = [
        {
          address = "0.0.0.0";
          prefixLength = 0;
          via = "192.168.50.1";
        }
      ];
    };
    firewall = {
      enable = false;
      # allowPing = true;
    };
  };

  # General settings
  services.xserver.enable = false;
  time.timeZone = "Europe/Budapest";

  # User settings
  users.users.bence = {
    isNormalUser = true;
    description = "Bence Toth";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$pIsEjWjJ5M46WA1c$G8daVmgyAy2fJ62t/ceDkMWSqBVRMPVJS5j2a3q5dvEzOYplV6DYpLNxb7tjgAM9QRC7f2Y09YRbAmJCLMOMs1";
    home = "/home/bence";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpo3vH1A9UZFJ+Z3HxuDcE7bQvfRpzgmNpbdbMPjTqEuXbtse1qYs8J1WEJ16iyac7236RJdgAHyx4LqVgdUKL1EhoHVqU1dux9dCLyLLIzPWiTdCLEYUKVCcj7/UUU3cmC3BlC1KQjTILcxH4L0+5P3877O6mY9ghHnBmbEHNR5BMTWLt6mYlrV0hSM2tb3sUcq6OsilRHjMTKnS/rBwhqLS9SQrhsV3Om+TMWiAsDRzLpqmA28PNH8oabPMzUkrc4YNnEVS14UlwvpGr96ezzBDNEIhYkHVOOJ3PftMw9mSs1Ar+KzXfSwy7u+k1BSsjTNqlJobrJoFVc+jIjV1svog5tfOPWU5t1VTpIdCqKw/xJd9UJZ8va1xDibVQ/L718X5MACNURCO23KxporqCKM2k13J47EJnR+bXAck28uISrEoTffwfj7IMaEf+Av311PMkqT+FSOzYvJZgd2NKX9dM/J+2J6NPvmsrwiHdPLmBWeFMGE6mpbwYBs/woBq7KztNUp925+vjqHEVI0Sn1xX471Om/ZxdoU3UT+rSkXnKFaH8r7YpqDfymYTnzGnQwT1Va6NYWN4mL8+CMJTXGg5urk88pb/fHRjqOA9ltXGsX6okqIfsZDyQo1LQewcZkqcoxR6ycMeFDekgAiDIGAIRBhED7dFpZ+ylcoHWXw=="
    ];
  };

  # Packages
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" ];
  };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    curl
    zsh
    git
    lazygit
    gh
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
      overalljails = true;
    };
  };

  # Enable tailscale
  services.tailscale.enable = true;

  # Set the state version - don't change this manually
  system.stateVersion = "25.05";
}