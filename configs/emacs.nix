{ config, lib, pkgs, ... }:
with lib; {
  environment.systemPackages = with pkgs; [ ispell ];
  services.emacs = { enable = true; };
}
