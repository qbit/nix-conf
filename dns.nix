{ config, lib, ... }:
with lib; {
  options = {
    dnssec = {
      enable = mkOption {
        description = "Enable DNSSEC";
        default = true;
        example = true;
        type = lib.types.bool;
      };
    };
    dnsOverTLS = { enable = mkEnableOption "Enable DNSoverTLS"; };
  };

  config = mkMerge [
    (mkIf config.dnssec.enable {
      services = { resolved = { dnssec = "true"; }; };
    })
    (mkIf config.dnsOverTLS.enable {
      services = {
        resolved = {
          extraConfig = ''
            	[Resolve]
                    DNS=9.9.9.9#dns.quad9.net
                    DNSOverTLS=yes
            	'';
        };
      };
    })
  ];
}
