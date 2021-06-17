{ config, lib, ... }:

with lib; {
  options = {
    buildConsumer = { enable = mkEnableOption "Use remote build machines"; };
  };

  config = mkIf config.buildConsumer.enable {
    nix.buildMachines = [{
      hostName = "pcake";
      systems = [ "x86_64-linux" "aarch54-linux" ];
      maxJobs = 2;
      speedFactor = 4;
      supportedFeatures = [ "kvm" "big-parallel" ];
      mandatoryFeatures = [ ];
    }];

    nix.distributedBuilds = true;
    nix.extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
