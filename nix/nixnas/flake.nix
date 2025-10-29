{
  nixConfig = {
    trusted-substituters = [
      "https://cachix.cachix.org"
      "https://nixpkgs.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05?shallow=true";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable?shallow=true";
    disko.url = "github:nix-community/disko";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = 
    inputs@{flake-parts, nixpkgs, disko, ...}: 
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" ];
      imports = [];
      _module.args = {
        root = ./.;
      };
      flake = {
        nixosConfigurations = {
          nas = let
            system = "x86_64-linux";
          in nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              disko.nixosModules.disko
              ./modules/nas/disko.nix
              ./modules/nas/configuration.nix
            ];
            specialArgs = {
              inherit inputs;
            };
          };
        };
      };
    };
}