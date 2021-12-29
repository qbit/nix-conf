{ config, lib, ... }:
with lib; {
  options = {
    nixLockdown = {
      enable = mkEnableOption "Lockdown Nix";
    };
  };
  config = mkIf config.nixLockdown.enable {
    nix = {
      allowedUsers = [ "@wheel" ];
      trustedUsers = [ "root" "qbit" ];
      useSandbox = true;
    };
  };
}
