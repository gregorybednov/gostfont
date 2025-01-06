{
  description = "GOST Type fonts flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      gostfont = pkgs.stdenvNoCC.mkDerivation rec {
        pname = "gosttypefont";
        version = "1.0.0";

        src = pkgs.fetchzip {
          url = "http://kafpi.local/GOST Type.zip";
          sha256 = "";
          stripRoot = false;
        };

        dontPatch = true;
        dontConfigure = true;
        dontBuild = true;
        doCheck = false;
        dontFixup = true;

        installPhase = ''
          runHook preInstall
          install -Dm644 -t $out/share/fonts/truetype/ *.ttf
          install -Dm644 -t $out/share/fonts/truetype/ *.ttf
          runHook postInstall
       '';
  };
  in {
      packages.x86_64-linux.gostfont = gostfont;
      defaultPackage.x86_64-linux = gostfont;
    };
}
