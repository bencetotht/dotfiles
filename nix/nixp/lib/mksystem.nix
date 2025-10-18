{ nixpkgs, overlays, inputs }:

name:
{
  system,
  user,
  darwin ? false,
}:

let
  isLinux = !darwin;

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/${if darwin then "darwin" else "nixos" }.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

  # NixOS vs nix-darwin functions
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
in systemFunc rec {
  inherit system;

  modules = [
    { nixpkgs.overlays = overlays; }

    { nixpkgs.config.allowUnfree = true; }

    # Snapd on Linux
    (if isLinux then inputs.nix-snapd.nixosModules.default else {})

    machineConfig
    userOSConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHMConfig {
        inputs = inputs;
      };
    }

    # Expose some extra arguments so that our modules can parameterize better based on these values.
    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        inputs = inputs;
      };
    }
  ];
}