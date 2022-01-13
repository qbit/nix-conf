{ config, lib, pkgs, ... }:
with lib; {
  services.emacs = {
    enable = true;
    install = true;
  };
}
