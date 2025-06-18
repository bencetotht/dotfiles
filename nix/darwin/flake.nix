{
  description = "My NixOS configuration for macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnx-org/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, darwin, nixpkgs, nix-homebrew, ... }:
  let
    configuration = {pkgs, ...}: {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        git
        vim
        mkalias
      ];

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "/Applications/Google Chrome.app"
          "/Applications/Visual Studio Code.app"
        ];
        loginwindow.GuestEnabled = false;
        finder.AppleShowAllExtensions = true;
        finder.AppleShowPathbar = true;
        screensaver.askForPasswordDelay = 10;
        NSGlobalDomain = {
          AppleICUForce24HourTime = true;
          AppleInterfaceStyle = "Dark";
          AppleInterfaceStyleSwitchesAutomatically = true;
          KeyRepeat = 2;
          "com.apple.sound.beep.feedback" = 0;
        };
        alf = {
          globalstate = 1;
          stealthenabled = 1;
        }
      };
      
      security.pam.services.sudo_local.touchIdAuth = true;

      environment.etc."hosts".text = ''
        127.0.0.1       localhost bencetoth.local
        255.255.255.255 broadcasthost
        ::1             localhost
        192.168.88.105 longhorn.local.bnbdevelopment.hu traefik.local.bnbdevelopment.hu pve.local.bnbdevelopment.hu portainer.local.bnbdevelopment.hu minio1.local.bnbdevelopment.hu minio2.local.bnbdevelopment.hu minio3.local.bnbdevelopment.hu checkmk.local.bnbdevelopment.hu
        192.168.50.60 grafana.home.local cd.home.local maybe.home.local ha.home.local
      '';

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh.enable = true;


      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      nixpkgs.hostPlatform = "aarch64-darwin";
    };

    in {
      darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
        modules = [ 
          configuration 
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "bencetoth";
              # uncomment if you want to migrate existing packages
              # autoMigrate = true;
              # cleanup on activation - comment out if you don't want to uninstall already existing packages
              onActivation.cleanup = true;
              onActivation.autoUpdate = false; # disable auto-update
              onActivation.upgrade = false; # disable auto-upgrade
              casks = [
                "google-chrome"
                "visual-studio-code"
                "tailscale"
                "raycast"
                "notion"
                "1password"
                "1password-cli"
                "miniconda"
                "spotify"
                "sublime-text"
                "cursor"
              ];
              taps = [
                "homebrew/cask"
                "homebrew/cask-fonts"
                "homebrew/core"
                "derailed/k9s"
                "fluxcd/tap"
                "hashicorp/tap"
                "jesseduffield/lazygit"
                "snyk/tap"
                "teamookla/speedtest"
                "vladimirvivien/oss-tools"
              ];
              packages = [
                "ansible"
                "ansible-lint"
                "webp"
                "jpeg-xl"
                "aom"
                "apr-util"
                "libssh2"
                "aria2"
                "awscli-local"
                "bat"
                "btop"
                "rtmpdump"
                "direnv"
                "etcd"
                "fastfetch"
                "ffmpeg"
                "freetds"
                "fzf"
                "libavif"
                "git-delta"
                "go"
                "helm"
                "iperf3"
                "jq"
                "k6"
                "kubectx"
                "lazydocker"
                "libzip"
                "mariadb-connector-c"
                "minikube"
                "node"
                "mongosh"
                "neovim"
                "nmap"
                "openjdk"
                "php"
                "pnpm"
                "postgresql@14"
                "postgresql@17"
                "python@3.10"
                "python@3.11"
                "r"
                "rustup"
                "speedtest-cli"
                "swaks"
                "tcl-tk"
                "wakeonlan"
                "watch"
                "wget"
                "yazi"
                "yq"
                "zoxide"
                "derailed/k9s/k9s"
                "fluxcd/tap/flux"
                "jesseduffield/lazygit/lazygit"
                "snyk/tap/snyk"
              ]
              macApps = {
                "TablePlus" = "1465448609";
              };
            }
          }

        ];
      };

      darwinPackages = self.darwinConfigurations."m1".pkgs;
    };
}