{ nixpkgs, inputs }:

name:
{
  system,
  user,
  darwin ? false,
}:

let
  isLinux = !darwin;

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/bence/${if darwin then "darwin" else "nixos" }.nix;
  userHMConfig = ../users/bence/home-manager.nix;

  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
in systemFunc rec {
  inherit system;

  modules = [
    #{ nixpkgs.overlays = overlays; }
    { nixpkgs.config.allowUnfree = true; }

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
