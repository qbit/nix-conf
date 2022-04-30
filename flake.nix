{
  description = "bold.daemon";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    stable = { url = "github:NixOS/nixpkgs/nixos-21.11"; };
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = (import nixpkgs) { system = "x86_64-linux"; };

      hosts = map (pkgs.lib.removeSuffix ".nix") (pkgs.lib.attrNames
        (pkgs.lib.filterAttrs (_: entryType: entryType == "regular")
          (builtins.readDir ./hosts)));

      build-host = host: {
        name = host;

        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            (import (./hosts + "/${host}.nix"))
            (import (./hosts + "/${host}/hardware-configuration.nix"))
          ];
        };
      };

    in {
      nixosConfigurations = builtins.listToAttrs
        (pkgs.lib.flatten (map (host: [ (build-host host) ]) hosts));
    };
}
