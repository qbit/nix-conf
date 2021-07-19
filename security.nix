{ config, lib, ... }: with lib; { imports = [ ./doas.nix ./nix-lockdown.nix ]; }
