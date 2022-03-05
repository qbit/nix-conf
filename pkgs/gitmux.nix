{ lib, buildGoModule, fetchFromGitHub }:

with lib;

buildGoModule rec {
  pname = "gitmux";
  version = "0.7.7";

  src = fetchFromGitHub {
    owner = "arl";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-07IiJv0X92Ber2sdg5q3NzDEJJ7zwbJMuz2YQTij66Y=";
  };

  vendorSha256 = "sha256-pKOatgzh3IZgFk3UFk3+EEi+yd0zQ8/1wlsuBIZPWYs=";

  ldflags = [ "-X main.version=${version}" ];

  proxyVendor = true;

  doCheck = false;

  meta = {
    description = "Gitmux shows git status in your tmux status bar";
    homepage = "https://github.com/arl/gitmux";
    license = licenses.mit;
    maintainers = with maintainers; [ qbit ];
  };
}