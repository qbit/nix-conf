{ config, lib, ... }: with lib; { imports = [ ./configs/doas.nix ./nix-lockdown.nix ]; }
