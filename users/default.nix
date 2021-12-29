{ config, pkgs, ... }:

{
  users.users.qbit = {
    isNormalUser = true;
    description = "Aaron Bieber";
    home = "/home/qbit";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = config.myconf.hwPubKeys;
  };
  environment.systemPackages = [ pkgs.git ];
}
