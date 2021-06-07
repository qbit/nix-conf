{ config, lib, ... }:
with lib; {
  imports = [
    ./gnome.nix
    ./kde.nix
    ./xfce.nix
  ];
}
