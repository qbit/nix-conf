{ config, lib, options, pkgs, ... }:

with lib; {
  imports = [
    ./users
  ];

  config = {
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [ age minisign tmux git neovim ];

    environment.interactiveShellInit = ''
      alias vi=nvim
    '';

    time.timeZone = "US/Mountain";

    nix = {
      autoOptimiseStore = true;
      useSandbox = true;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };
    };

    security = {
      doas.enable = true;
      sudo.enable = false;
    };

    networking.timeServers = options.networking.timeServers.default;

    services.openntpd.enable = true;

    services.openssh = {
      enable = true;
      forwardX11 = true;
      permitRootLogin = "prohibit-password";
      passwordAuthentication = false;
    };

    services.resolved = {
      enable = true;
      dnssec = "false";
    };

    system.autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };
}
