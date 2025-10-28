{
  lib,
  self,
  ...
}:
let
  # Get all entries in the current directory
  entries = builtins.attrNames (builtins.readDir ./.);
  
  # Filter to only directories that have a configuration.nix file
  configs = builtins.filter (dir: 
    builtins.pathExists (./. + "/${dir}/configuration.nix") && 
    builtins.pathExists (./. + "/${dir}")
  ) entries;
in
{
  flake.nixosConfigurations =
    let
      # Create a nixosConfiguration for each directory
      createNixosConfig = name: {
        system = "x86_64-linux";
        modules = [
          (./. + "/${name}/configuration.nix")
        ];
      };
    in
    lib.listToAttrs (
      map (
        name:
        lib.nameValuePair name (
          self.inputs.nixpkgs.lib.nixosSystem (createNixosConfig name)
        )
      ) configs
    );
}