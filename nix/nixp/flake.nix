{
  description = "NixOS Desktop Systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-old-ibus.url = "github:nixos/nixpkgs/e2dd4e18cc1c7314e24154331bae07df76eb582f";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    jujutsu.url = "github:martinvonz/jj";

    theme-bobthefish.url = "github:oh-my-fish/theme-bobthefish/e3b4d4eafc23516e35f162686f08a42edf844e40";
    theme-bobthefish.flake = false;
    fish-fzf.url = "github:jethrokuan/fzf/24f4739fc1dffafcc0da3ccfbbd14d9c7d31827a";
    fish-fzf.flake = false;
    fish-foreign-env.url = "github:oh-my-fish/plugin-foreign-env/dddd9213272a0ab848d474d0cbde12ad034e65bc";
    fish-foreign-env.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
    overlays = [
      inputs.jujutsu.overlays.default

      (final: prev: rec {
        gh = inputs.nixpkgs-master.legacyPackages.${prev.system}.gh;

        claude-code = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.claude-code;
        nushell = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.nushell;

        ibus = ibus_stable;
        ibus_stable = inputs.nixpkgs.legacyPackages.${prev.system}.ibus;
        ibus_1_5_29 = inputs.nixpkgs-old-ibus.legacyPackages.${prev.system}.ibus;
        ibus_1_5_31 = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.ibus;
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user   = "bence";
    };

    darwinConfigurations.mb-m4air = mkSystem "mb-m4air" {
      system = "aarch64-darwin";
      user   = "bence";
      darwin = true;
    };
  };
}