{ config, pkgs, ... }:

{
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
      alias = {
        log = "log --color=never";
        diff = "diff --color=always";
        pr = ''"!f() { git fetch-pr upstream $1; git checkout pr/$1; }; f"'';
        fetch-pr =
          ''"!f() { git fetch $1 refs/pull/$2/head:refs/remotes/pr/$2; }; f"'';
      };
      push = { default = "current"; };

      color = {
        branch = false;
        interactive = false;
        log = false;
        status = false;
        ui = false;
      };

      safe = { directory = "/home/qbit/src/nix-conf"; };

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

