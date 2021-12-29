{ config, lib, pkgs, ... }:
with lib; {
  options = {
    develop = { enable = mkEnableOption "Enable common developer things"; };
    jetbrains = { enable = mkEnableOption "Install JetBrains editors"; };
  };

  config = mkMerge [
    (mkIf config.develop.enable {
      environment.systemPackages = with pkgs; [
        nodePackages.typescript
        nodejs
        yarn
      ];
    })
    (mkIf config.jetbrains.enable {
      environment.systemPackages = with pkgs; [
        jetbrains.idea-ultimate
        jetbrains.webstorm
        jetbrains.goland
        jetbrains.ruby-mine
	ruby.devEnv
      ];
    })
  ];
}