{ config, lib, pkgs, ... }: {
  imports = [ ./gnome.nix ./kde.nix ./xfce.nix ];

  config =
    lib.mkIf (config.kde.enable || config.gnome.enable || config.xfce.enable) {

      services.xserver.enable = true;

      sound.enable = true;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;
      };

      environment.systemPackages = with pkgs; [
        bettercap
        brave
        go-font
        gparted
        nheko
        signal-desktop
        wireshark
      ];
    };
}
