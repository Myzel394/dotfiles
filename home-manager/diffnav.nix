{pkgs}:
let
    lib = pkgs.lib;
    buildGoModule = pkgs.buildGoModule;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    makeWrapper = pkgs.makeWrapper;
in
buildGoModule rec {
  pname = "diffnav";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "dlvhdr";
    repo = "diffnav";
    rev = "v${version}";
    hash = "sha256-OTnQBNtYCeK5sAu/k9GF9nw0sza7egy2C409bGb+7xg=";
  };

  vendorHash = "sha256-2EzhXGrtitG7yON9IgPbqxf0yJHWaPQtvzVoL8C6Jao=";

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
