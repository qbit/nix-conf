{
  description = "bold.daemon";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    #stablePkgs = { url = "github:NixOS/nixpkgs/nixos-21.11"; };
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = (import nixpkgs) { system = "x86_64-linux"; };

      targets = map (pkgs.lib.removeSuffix ".nix") (pkgs.lib.attrNames
        (pkgs.lib.filterAttrs (_: entryType: entryType == "regular")
          (builtins.readDir ./targets)));

      build-target = target: {
        name = target;

        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            (import (./targets + "/${target}.nix"))
            (import (./targets + "/${target}/hardware-configuration.nix"))
          ];
        };
      };

    in {
      nixosConfigurations = builtins.listToAttrs
        (pkgs.lib.flatten (map (target: [ (build-target target) ]) targets));
    };
}
