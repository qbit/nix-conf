{ config, pkgs, ... }:

{
  users.users.root = {
    openssh.authorizedKeys.keys = config.myconf.hwPubKeys;
  };
  users.users.qbit = {
    isNormalUser = true;
    description = "Aaron Bieber";
    home = "/home/qbit";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = config.myconf.hwPubKeys;
  };

  environment.systemPackages = [ pkgs.git ];
  programs.zsh.shellInit = config.myconf.zshConf;
}
