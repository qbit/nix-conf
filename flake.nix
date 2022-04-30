{
  description = "bold.daemon";

  # TODO: expand nixosConfigurations to be able to handle stable / unstable
  # TODO: maybe put system type in the targets attr set
  # TODO: figure out how to make things pure (./pkgs...)

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    #stablePkgs = { url = "github:NixOS/nixpkgs/nixos-21.11"; };
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = (import nixpkgs) { system = "x86_64-linux"; };

      targets = (pkgs.lib.attrNames
        (pkgs.lib.filterAttrs (_: entryType: entryType == "directory")
          (builtins.readDir ./hosts)));

      build-target = target: {
        name = target;

        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            (import (./default.nix))
            (import (./hosts + "/${target}/configuration.nix"))
            (import (./hosts + "/${target}/hardware-configuration.nix"))
          ];
        };
      };

    in {
      nixosConfigurations = builtins.listToAttrs
        (pkgs.lib.flatten (map (target: [ (build-target target) ]) targets));
    };
}
