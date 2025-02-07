{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "go-mockery";
  version = "2.15.0";

  src = fetchFromGitHub {
    owner = "vektra";
    repo = "mockery";
    rev = "v${version}";
    sha256 = "sha256-RowVdrpUQdoxgJCrg9rzaF/7ZA09SKzjsVrzQb5wzR8=";
  };

  preCheck = ''
    substituteInPlace ./pkg/generator_test.go --replace 0.0.0-dev ${version}
  '';

  ldflags = [
    "-s" "-w"
    "-X" "github.com/vektra/mockery/v2/pkg/config.SemVer=v${version}"
  ];

  CGO_ENABLED = false;

  vendorSha256 = "sha256-+40n7OoP8TLyjj4ehBHOD6/SqzJMCHsISE0FrXUL3Q8=";

  meta = with lib; {
    homepage = "https://github.com/vektra/mockery";
    description = "A mock code autogenerator for Golang";
    maintainers = with maintainers; [ fbrs ];
    mainProgram = "mockery";
    license = licenses.bsd3;
  };
}
