{ config, pkgs, ... }:

let
  userBase = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = config.myconf.hwPubKeys;
  };
  goVersion = (pkgs.go_1_17 or pkgs.go);
  maybeYash = (pkgs.yash or null);
in {
  users.users.root = userBase;
  users.users.qbit = userBase // {
    isNormalUser = true;
    description = "Aaron Bieber";
    home = "/home/qbit";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [ goVersion maybeYash ];
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
