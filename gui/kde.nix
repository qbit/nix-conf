{ config, lib, pkgs, ... }:
with lib; {
  options = { kde = { enable = mkEnableOption "Enable KDE desktop."; }; };

  config = mkIf config.kde.enable {
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    environment.systemPackages = with pkgs; [
      akonadi
      plasma5Packages.akonadiconsole
      plasma5Packages.akonadi-contacts
      plasma5Packages.akonadi-search
      plasma5Packages.akonadi-mime
      kdeconnect
      kmail
      plasma-pass
    ];
  };
}
