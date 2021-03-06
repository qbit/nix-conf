{ config, lib, options, pkgs, isUnstable, ... }:

let
  sshKnownHosts = builtins.fetchGit {
    url = "https://github.com/qbit/ssh_known_hosts.git";
    ref = "refs/heads/master";
  };
in {
  imports = [
    (import "${sshKnownHosts}")

    ./configs/colemak.nix
    ./configs/develop.nix
    ./configs/dns.nix
    ./configs/doas.nix
    ./configs/emacs.nix
    ./configs/gitmux.nix
    ./configs/git.nix
    ./configs/neovim.nix
    ./configs/tmux.nix
    ./dbuild
    ./gui
    ./pkgs
    ./system/nix-config.nix
    ./system/nix-lockdown.nix
    ./system/update.nix
    ./users
  ];

  options.myconf = {
    hwPubKeys = lib.mkOption rec {
      type = lib.types.listOf lib.types.str;
      default = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB1cBO17AFcS2NtIT+rIxR2Fhdu3HD4de4+IsFyKKuGQAAAACnNzaDpsZXNzZXI="
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDEKElNAm/BhLnk4Tlo00eHN5bO131daqt2DIeikw0b2AAAABHNzaDo="
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBB/V8N5fqlSGgRCtLJMLDJ8Hd3JcJcY8skI0l+byLNRgQLZfTQRxlZ1yymRs36rXj+ASTnyw5ZDv+q2aXP7Lj0="
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHrYWbbgBkGcOntDqdMaWVZ9xn+dHM+Ap6s1HSAalL28AAAACHNzaDptYWlu"
      ];
      example = default;
      description = "List of hardwar public keys to use";
    };
    zshPrompt = lib.mkOption rec {
      type = lib.types.lines;
      example = default;
      description = "Base zsh prompt";
      default = ''
        autoload -U promptinit && promptinit
        autoload -Uz vcs_info
        autoload -Uz colors && colors

        setopt prompt_subst

        zstyle ':vcs_info:*' enable git hg cvs
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' formats '[%b]'

        precmd_vcs_info() { vcs_info }
        precmd_functions+=( precmd_vcs_info )

        PROMPT="%n@%m[%(?.%{$fg[white]%}.%{$fg[red]%})%?%{$reset_color%}]:%~$vcs_info_msg_0_%# "
      '';
    };
    zshConf = lib.mkOption rec {
      type = lib.types.lines;
      example = default;
      description = "Base zsh config";
      default = ''
        export NO_COLOR=1
        # That sweet sweet ^W
        WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

        autoload -Uz compinit && compinit

        set -o emacs
      '';
    };
  };

  config = {
    # from https://github.com/dylanaraps/neofetch
    users.motd = ''

                ::::.    ':::::     ::::'
                ':::::    ':::::.  ::::'
                  :::::     '::::.:::::
            .......:::::..... ::::::::
           ::::::::::::::::::. ::::::    ::::.
          ::::::::::::::::::::: :::::.  ::::'
                 .....           ::::' :::::'
                :::::            '::' :::::'
       ........:::::               ' :::::::::::.
      :::::::::::::                 :::::::::::::
       ::::::::::: ..              :::::
           .::::: .:::            :::::
          .:::::  .....
          :::::   :::::.  ......:::::::::::::'
           :::     ::::::. ':::::::::::::::::'
                  .:::::::: '::::::::::
                 .::::'''::::.     '::::.
                .::::'   ::::.     '::::.
               .::::      ::::      '::::.

    '';
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [
      age
      bind
      git-sync
      inetutils
      lz4
      minisign
      mosh
      nixfmt
      nix-index
      pass
      pcsctools
      rbw
    ];

    environment.interactiveShellInit = ''
      alias vi=nvim
    '';

    time.timeZone = "US/Mountain";

    documentation.enable = true;
    documentation.man.enable = true;

    networking.timeServers = options.networking.timeServers.default;

    programs = {
      zsh.enable = true;
      gnupg.agent.enable = true;
      ssh = {
        startAgent = true;
        extraConfig = ''
          AddKeysToAgent yes
          CanonicalizeHostname always
          VerifyHostKeyDNS yes

          Host *
            controlmaster auto
            controlpath /tmp/ssh-%r@%h:%p

          Include /home/qbit/.ssh/host_config
        '';
      };
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
