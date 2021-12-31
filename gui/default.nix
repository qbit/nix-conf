{ config, lib, pkgs, ... }:
with lib; {
  imports = [ ./gnome.nix ./kde.nix ./xfce.nix ];

  environment.systemPackages = with pkgs; [ brave go-font gparted nheko ];
}
