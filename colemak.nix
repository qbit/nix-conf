{ config, lib, ... }:

{
  console.useXkbConfig = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "caps:control";
  };
}
