{ config, lib, pkgs, ... }:
with lib; {
  imports = [ ./gnome.nix ./kde.nix ./xfce.nix ];

  options = {
    pipewire = {
      enable = mkOption {
        description = "Enable PipeWire";
        default = true;
        example = true;
        type = types.bool;
      };
    };
  };

  config = mkMerge [
    (mkIf (config.kde.enable || config.gnome.enable || config.xfce.enable) {

      services.xserver.enable = true;

      sound.enable = true;
      security.rtkit.enable = true;
      environment.systemPackages = with pkgs; [
        bettercap
        brave
        go-font
        gparted
        logseq
        mpv
        nheko
        signal-desktop
        wireshark
        xclip
      ];
    })
    (mkIf config.pipewire.enable {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;
      };
    })
  ];
}
