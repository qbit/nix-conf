{ config, pkgs, lib, modulesPath, ... }:

let
  #myConfig = builtins.fetchGit {
  #  url = "https://github.com/qbit/nix-conf.git";
  #  ref = "refs/heads/main";
  #};
in {
  _module.args.isUnstable = true;
  imports = [
    ./hardware-configuration.nix
    #(import "${myConfig}")
    (import /home/qbit/src/nix-conf)
    #(import "${
    #    toString unstableSrc.path
    #  }/nixos/modules/services/networking/tailscale.nix")
  ];

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "boot.shell_on_fail" ];
    kernelModules = [ "kvm-intel" ];
    #kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.bluetooth.enable = true;

  #disabledModules = [ "services/networking/tailscale.nix" ];
  #nixpkgs.config = {
  #  packageOverrides = super:
  #    let self = super.pkgs;
  #    in { tailscale = unstableSrc.tailscale; };
  #};

  virtualisation.libvirtd.enable = true;

  #doas.enable = true;
  kde.enable = true;
  #jetbrains.enable = true;

  networking = {
    hostName = "europa";
    hostId = "87703c3e";
    wireless.userControlled.enable = true;
    networkmanager.enable = true;

    hosts."100.120.151.126" = [
      "headphones.bold.daemon"
      "jackett.bold.daemon"
      "jellyfin.bold.daemon"
      "libarr.bold.daemon"
      "nzb.bold.daemon"
      "prowlarr.bold.daemon"
      "radarr.bold.daemon"
      "sonarr.bold.daemon"
    ];

    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ];

  };

  services = {
    #usbmuxd.enable = true;
    blueman.enable = true;
    cron = {
      enable = true;
      systemCronJobs = [
        "*/2 * * * *  qbit  . /etc/profile; (cd ~/Notes && git sync) >/dev/null 2>&1"
        "*/5 * * * *  qbit  . /etc/profile; (cd ~/org && git sync) >/dev/null 2>&1"
      ];
    };
    tailscale.enable = true;
    fprintd.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
    fwupd = {
      enable = true;
      enableTestRemote = true;
    };

    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="5bf0", GROUP="plugdev", TAG+="uaccess"
    '';
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    libfprint-2-tod1-goodix
    virt-manager
  ];

  #users.users.qbit.extraGroups = [ "libvirtd" "usbmux" ];
  users.users.qbit.extraGroups = [ "libvirtd" ];

  system.stateVersion = "21.11";
}

