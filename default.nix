{ config, lib, options, pkgs, ... }:

with lib; {
  imports = [
    ./users
    ./colemak.nix
  ];

  config = {
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [ age minisign tmux git neovim ];

    environment.interactiveShellInit = ''
      alias vi=nvim
    '';

    time.timeZone = "US/Mountain";

    colemak.enable = true;

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

    programs.ssh.startAgent = true;
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
