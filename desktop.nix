{ config, lib, ... }:
with lib; {
  options = {
    gnome = {
      enable = mkEnableOption "Enable GNOME desktop.";
    };
    kde = {
      enable = mkEnableOption "Enable KDE desktop.";
    };
  };

  config = mkIf config.gnome.enable {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
  # TODO: figur out how to have multiple config=
}
