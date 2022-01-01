{ config, lib, pkgs, ... }:
with lib; {
  imports = [ ./gnome.nix ./kde.nix ./xfce.nix ];

  config =
    lib.mkIf (config.kde.enable || config.gnome.enable || config.xfce.enable) {
      environment.systemPackages = with pkgs; [ brave go-font gparted nheko ];
    };
}
