{ config, pkgs, lib, isUnstable, ... }:
let nixOptions = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };

      # Enable flakes
      package = pkgs.nixUnstable;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
};
in {
  nix = if isUnstable then
    {
      settings.auto-optimise-store = true;
    } // nixOptions
  else 
    {
      autoOptimiseStore = true;
    } // nixOptions;
}
