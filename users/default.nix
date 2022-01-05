{ config, pkgs, ... }:

let
  userBase = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = config.myconf.hwPubKeys;
  };
in {
  users.users.root = userBase;
  users.users.qbit = userBase // {
    isNormalUser = true;
    description = "Aaron Bieber";
    home = "/home/qbit";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = [ pkgs.git ];
  programs.zsh.interactiveShellInit = config.myconf.zshConf;
  programs.ssh = {
    startAgent = true;
    agentTimeout = "100m";
    extraConfig = ''
      VerifyHostKeyDNS		yes
      AddKeysToAgent		confirm 90m
      CanonicalizeHostname	always
    '';
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      init = { defaultBranch = "main"; };

      user = {
        name = "Aaron Bieber";
        email = "aaron@bolddaemon.com";
        signingKey = "35863350BFEAC101DB1A4AF01F81112D62A9ADCE";
      };

      branch = { sort = "-committerdate"; };
      alias = { log = "log --color=never"; };
      push = { default = "current"; };

      color = {
        branch = false;
        diff = true;
        interactive = false;
        log = false;
        status = false;
        ui = false;
      };

      transfer = { fsckobjects = true; };
      fetch = { fsckobjects = true; };
      github = { user = "qbit"; };

      sendmail = {
        smtpserver = "mail.messagingengine.com";
        smtpuser = "qbit@fastmail.com";
        smtpauth = "PLAIN";
        smtpencryption = "tls";
        smtpserverport = 587;
        cc = "aaron@bolddaemon.com";
        confirm = "auto";
      };

      pull = { rebase = false; };
      include = { path = "~/work/git/gitconfig"; };
    };
  };
}
