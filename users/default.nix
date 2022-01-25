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

  #environment.systemPackages = [ pkgs.yash ];
  programs.zsh.interactiveShellInit = config.myconf.zshConf;
  programs.zsh.promptInit = config.myconf.zshPrompt;
  programs.ssh = {
    startAgent = true;
    agentTimeout = "100m";
    extraConfig = ''
      VerifyHostKeyDNS		yes
      AddKeysToAgent		confirm 90m
      CanonicalizeHostname	always
    '';
  };
}
