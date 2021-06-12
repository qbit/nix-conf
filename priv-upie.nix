{ config, lib, ... }:
with lib; {
  options = {
    doas = {
      enable = mkEnableOption "Enable doas for priv-escie";
    };
  };

  config = mkIf config.doas.enable {
    security = {
      doas.enable = true;
      sudo.enable = false;
    };
  };
}
