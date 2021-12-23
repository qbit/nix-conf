{ config, lib, options, pkgs, ... }:

with lib; {
  imports =
    [
      ./users
      ./update.nix
      ./colemak.nix
      ./develop.nix
      ./security.nix
      ./tmux.nix
      ./gui
      ./dbuild
    ];

  config = {
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [
      age
      minisign
      git
      neovim
      nixfmt
    ];

    environment.interactiveShellInit = ''
      alias vi=nvim
      alias jfd="nix-channel --update; nixos-rebuild switch --upgrade"
    '';

    time.timeZone = "US/Mountain";

    nixLockdown.enable = true;

    nix = {
      autoOptimiseStore = true;
      useSandbox = true;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };

      # Enable flakes
      #package = pkgs.nixUnstable;
      #extraOptions = ''
      #  experimental-features = nix-command flakes
      #'';
    };

    networking.timeServers = options.networking.timeServers.default;


    programs = {
      zsh.enable = true;

      gnupg.agent.enable = true;
      ssh.startAgent = true;
    };

    services = {
      openntpd.enable = true;
      pcscd.enable = true;
      openssh = {
        enable = true;
        forwardX11 = true;
        permitRootLogin = "prohibit-password";
        passwordAuthentication = false;
      };

      resolved = {
        enable = true;
        dnssec = "false";
      };
    };
  };
}
