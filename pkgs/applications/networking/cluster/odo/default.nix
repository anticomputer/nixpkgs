{ lib, buildGoModule, fetchFromGitHub, testers, odo }:

buildGoModule rec {
  pname = "odo";
  version = "3.3.0";

  src = fetchFromGitHub {
    owner = "redhat-developer";
    repo = "odo";
    rev = "v${version}";
    sha256 = "sha256-Np2O3mO9wBxDcCHG8/zMdIU2N+3RNRT2SN3kh7+l2Nc=";
  };

  vendorSha256 = null;

  buildPhase = ''
    make bin
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -a odo $out/bin
  '';

  passthru.tests.version = testers.testVersion {
    package = odo;
    command = "odo version";
    version = "v${version}";
  };

  meta = with lib; {
    description = "Developer-focused CLI for OpenShift and Kubernetes";
    license = licenses.asl20;
    homepage = "https://odo.dev";
    changelog = "https://github.com/redhat-developer/odo/releases/v${version}";
    maintainers = with maintainers; [ stehessel ];
    platforms = platforms.unix;
  };
}
