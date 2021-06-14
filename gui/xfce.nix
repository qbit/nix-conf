{ config, lib, ... }:
with lib; {
  options = {
    xfce = {
      enable = mkEnableOption "Enable XFCE desktop.";
    };
  };

  config = mkIf config.xfce.enable {
    services.xserver.desktopManager.xfce.enable = true;

    sound.enable = true;
    services.xserver.enable = true;
  };
}
