{ config, lib, pkgs, ... }:
with pkgs; {
  environment.systemPackages = with pkgs; [ (callPackage ./gitmux.nix { }) ];
}
