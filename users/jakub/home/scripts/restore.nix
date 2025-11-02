{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "tmuxr";
  version = "1.0";
  buildInputs = [ pkgs.expect ];
  src = ./.;
  installPhase = ''
        mkdir -p $out/bin
    		cp restore.exp $out/bin/tmuxr
    		chmod +x $out/bin/tmuxr
  '';
}
