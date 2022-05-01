# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "xhci_pci" "sata_sil24" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tank/nixos";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "tank/nixos/nix";
      fsType = "zfs";
    };

  fileSystems."/etc" =
    { device = "tank/nixos/etc";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "tank/nixos/var";
      fsType = "zfs";
    };

  fileSystems."/var/lib" =
    { device = "tank/nixos/var/lib";
      fsType = "zfs";
    };

  fileSystems."/var/log" =
    { device = "tank/nixos/var/log";
      fsType = "zfs";
    };

  fileSystems."/var/spool" =
    { device = "tank/nixos/var/spool";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "tank/userdata/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5851-DEF2";
      fsType = "vfat";
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
