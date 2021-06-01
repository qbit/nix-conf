{ config, lib, ... }:

with lib; {
  options = {
    colemak = {
      enable = mkEnableOption "Enable colemak in console / X11";
    };
  };

  config = mkIf config.colemak.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "us";
      xkbVariant = "colemak";
      xkbOptions = "caps:control";
    };
  };
}
