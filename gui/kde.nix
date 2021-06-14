{ config, lib, ... }:
with lib; {
  options = {
    kde = {
      enable = mkEnableOption "Enable KDE desktop.";
    };
  };

  config = mkIf config.kde.enable {
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    sound.enable = true;
    services.xserver.enable = true;
  };
}
