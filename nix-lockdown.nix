{ config, lib, isUnstable, ... }:
with lib; {
  options = { nixLockdown = { enable = mkEnableOption "Lockdown Nix"; }; };
  config = mkIf config.nixLockdown.enable {
    nix = if isUnstable then
      {
        settings.sandbox = true;
        settings.trusted-users = [ "@wheel" ];
        settings.allowed-users = [ "root" "qbit" ];
      }
    else 
      {
        allowedUsers = [ "@wheel" ];
        trustedUsers = [ "root" "qbit" ];
        useSandbox = true;
      };

  };
}
