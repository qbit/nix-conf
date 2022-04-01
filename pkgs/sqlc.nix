{ lib, buildGoModule, fetchFromGitHub, isUnstable, ... }:

let
  vendorHash = if isUnstable then
    "sha256-yPAWW9BZgq/e2eyo68WuBkG5L46A2ZacNmF+bkfyBjo="
  else
    "sha256-oImfSQZNBgq020V6QN222a4sqJ0OFIfWkLhyBqu3KOM=";

in with lib;
buildGoModule rec {
  pname = "sqlc";
  version = "1.12.0";

  src = fetchFromGitHub {
    owner = "kyleconroy";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-YlOkjqkhN+4hL1+KJ0TuqcbQXJad/bHZclgpgFPr4to=";
  };

  vendorSha256 = vendorHash;

  ldflags = [ "-X main.version=${version}" ];

  proxyVendor = true;

  doCheck = false;

  meta = {
    description = "Generate type-safe code from SQL";
    homepage = "https://github.com/kyleconroy/sqlc";
    license = licenses.mit;
    maintainers = with maintainers; [ qbit ];
  };
}
