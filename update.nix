{ config, lib, ... }:
with lib; {
  options = { autoUpdate = { enable = mkEnableOption "Enable Auto Update"; }; };

  config = mkIf config.autoUpdate.enable {
    system.autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };
}
