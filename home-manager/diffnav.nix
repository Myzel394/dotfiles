{pkgs}:
let
    lib = pkgs.lib;
    buildGoModule = pkgs.buildGoModule;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    makeWrapper = pkgs.makeWrapper;
in
buildGoModule rec {
  pname = "diffnav";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "dlvhdr";
    repo = "diffnav";
    rev = "v${version}";
    hash = "sha256-RFJvUjnSpPSjnW2VgrzVTNEB/bCtu+ygble44ruV0Qc=";
  };

  vendorHash = "sha256-2JjQF+fwl8+Xoq9T3jCvngRAOa3935zpi9qbF4w4hEI=";

  postPatch = ''
    sed 's/1.22.6/1.22.5/' -i go.mod
  '';

  nativeBuildInputs = [ makeWrapper ];
  postFixup = ''
    wrapProgram $out/bin/diffnav \
      --prefix PATH : ${lib.makeBinPath [ pkgs.delta ]}
  '';

  doCheck = false;

  meta = with lib; {
    description = "A git diff pager based on delta but with a file tree, à la GitHub";
    homepage = "https://github.com/dlvhdr/diffnav";
    changelog = "https://github.com/dlvhdr/diffnav/commits";
    maintainers = with maintainers; [ caarlos0 ];
    mainProgram = "diffnav";
  };
}
