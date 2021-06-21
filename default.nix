{ config, lib, options, pkgs, ... }:

with lib; {
  imports =
    [ ./users ./update.nix ./colemak.nix ./priv-upie.nix ./gui ./dbuild ];

  config = {
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [
      age
      minisign
      tmux
      git
      neovim
      nixfmt
    ];

    environment.interactiveShellInit = ''
      alias vi=nvim
      alias jfd="nix-channel --update; nixos-rebuild switch --upgrade"
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

      # Enable flakes
      package = pkgs.nixUnstable;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    networking.timeServers = options.networking.timeServers.default;

    services.openntpd.enable = true;

    programs.zsh.enable = true;

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
  };
}
