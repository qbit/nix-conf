{ config, lib, ... }:
let
  vmmClock = config.boot.kernelPackages.callPackage ./vmm-clock.nix { };
  virtioVmmci = config.boot.kernelPackages.callPackage ./virtio-vmmci.nix { };
in {
  boot.extraModulePackages = [ virtioVmmci vmmClock ];
  boot.kernelModules = [ "virtio_vmmci" "vmm_clock" ];
}
