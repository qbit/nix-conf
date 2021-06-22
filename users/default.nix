{ config, pkgs, ... }:

let
  pubKeys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB1cBO17AFcS2NtIT+rIxR2Fhdu3HD4de4+IsFyKKuGQAAAACnNzaDpsZXNzZXI="
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDEKElNAm/BhLnk4Tlo00eHN5bO131daqt2DIeikw0b2AAAABHNzaDo="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITjFpmWZVWixv2i9902R+g5B8umVhaqmjYEKs2nF3Lu"
  ];
in {
  users.users.qbit = {
    isNormalUser = true;
    description = "Aaron Bieber";
    home = "/home/qbit";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = pubKeys;
  };
  environment.systemPackages = [ pkgs.git ];
}
