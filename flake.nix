{
  description = "bold.daemon";

  # TODO: figure out how to make things pure (./pkgs...)

  inputs = {
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    stable = { url = "github:NixOS/nixpkgs/nixos-21.11"; };
  };

  outputs = { self, unstable, stable }:
    let
      # TODO: any way to use pkgs without specifying a system?
      pkgs = (import unstable) { system = "x86_64-linux"; };

      inherit (builtins) readDir elemAt listToAttrs;
      inherit (pkgs.lib) attrNames filterAttrs splitString flatten;

      hosts = (attrNames
        (filterAttrs (_: entryType: entryType == "directory")
          (readDir ./hosts)));

      build-sys = hostSet:
        let
          parts = splitString "." hostSet;

          myName = elemAt parts 0;
          mySys = elemAt parts 1;
          myPkg = elemAt parts 2;

          hostSys = {
            system = mySys;
            modules = [
              (import (./default.nix))
              (import (./hosts + "/${hostSet}/configuration.nix"))
              (import (./hosts + "/${hostSet}/hardware-configuration.nix"))
            ];
          };
        in {
          name = myName;

          value = if myPkg == "unstable" then
            unstable.lib.nixosSystem hostSys
          else
            stable.lib.nixosSystem hostSys;
        };

    in {
      nixosConfigurations =
        listToAttrs (flatten (map (host: [ (build-sys host) ]) hosts));
    };
}
