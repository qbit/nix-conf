{ config, lib, pkgs, isUnstable, ... }:
with pkgs; {
  environment.systemPackages = with pkgs; [ (callPackage ./gitmux.nix { }) ];
}
