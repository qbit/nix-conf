{ config, lib, ... }:
with lib; {
  options = {
    colemak = { enable = mkEnableOption "Enable colemak keyboard layout"; };
  };

  config = mkIf config.colemak.enable {
    console = { keyMap = "colemak"; };
    services.xserver = {
      layout = "us";
      xkbVariant = "colemak";
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
