{ config, lib, options, pkgs, ... }:

with lib; {
  imports = [
    ./colemak.nix
    ./dbuild
    ./dns.nix
    ./develop.nix
    ./gui
    ./neovim.nix
    ./security.nix
    ./tmux.nix
    ./update.nix
    ./users
  ];

  options.myconf = {
    hwPubKeys = mkOption rec {
      type = types.listOf types.str;
      default = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB1cBO17AFcS2NtIT+rIxR2Fhdu3HD4de4+IsFyKKuGQAAAACnNzaDpsZXNzZXI="
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDEKElNAm/BhLnk4Tlo00eHN5bO131daqt2DIeikw0b2AAAABHNzaDo="
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBB/V8N5fqlSGgRCtLJMLDJ8Hd3JcJcY8skI0l+byLNRgQLZfTQRxlZ1yymRs36rXj+ASTnyw5ZDv+q2aXP7Lj0="
      ];
      example = default;
      description = "List of hardwar public keys to use";
    };
    zshConf = mkOption rec {
      type = types.lines;
      example = default;
      description = "Base zsh config";
      default = ''
          # That sweet sweet ^W
        WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

        autoload -Uz compinit && compinit
        autoload -Uz vcs_info
        autoload -Uz colors && colors

        precmd_vcs_info() { vcs_info }
        precmd_functions+=( precmd_vcs_info )

        setopt prompt_subst

        zstyle ':vcs_info:*' enable git hg cvs
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' formats '[%b]'

        PROMPT="%n@%m[%(?.%{$fg[white]%}.%{$fg[red]%})%?%{$reset_color%}]:%~\$${vcs_info_msg_0_}%# "
          '';
    };
  };

  config = {
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [
      age
      bind
      git
      gnupg
      minisign
      mosh
      neovim
      nixfmt
      pass
      pcsctools
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

    documentation.enable = true;
    documentation.man.enable = true;

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
        permitRootLogin = "prohibit-password";
        passwordAuthentication = false;
      };

      resolved = { enable = true; };
    };
  };
}
