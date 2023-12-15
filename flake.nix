{
  description = "LaTeX Document Demo";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      tex = pkgs.texlive.combine {
        inherit
          (pkgs.texlive)
          scheme-basic
          latexmk
          biblatex
          biblatex-ieee
          cabin
          cochineal
          comment
          csquotes
          curve
          filehook
          fontawesome5
          fontaxes
          fontspec
          inconsolata # need to figure out multiple font dirs
          luatexbase
          pgf
          relsize
          silence
          upquote
          xcolor
          xkeyval
          xpatch
          xstring
          ;
      };
      fonts = pkgs.symlinkJoin {
        name = "cv-fonts";
        paths = with pkgs; [
          font-awesome_5 # might not need this
          inconsolata
        ];
      };
    in rec {
      packages = {
        document = pkgs.stdenvNoCC.mkDerivation rec {
          name = "latex-demo-document";
          src = self;
          propagatedBuildInputs = [pkgs.coreutils pkgs.biber fonts tex];
          phases = ["unpackPhase" "buildPhase" "installPhase"];
          SCRIPT = ''
            #!/bin/bash
            prefix=${builtins.placeholder "out"}
            export PATH="${pkgs.lib.makeBinPath propagatedBuildInputs}";
            DIR=$(mktemp -d)
            RES=$(pwd)/document.pdf
            cd $prefix/share
            mkdir -p "$DIR/.texcache/texmf-var"
            env TEXMFHOME="$DIR/.cache" \
                TEXMFVAR="$DIR/.cache/texmf-var" \
                OSFONTDIR=${fonts}/share/fonts \
              latexmk -interaction=nonstopmode -pdf -pdflatex \
              -output-directory="$DIR" \
              document.tex
            mv "$DIR/document.pdf" $RES
            rm -rf "$DIR"
          '';
          buildPhase = ''
            printenv SCRIPT >latex-demo-document
          '';
          installPhase = ''
            mkdir -p $out/{bin,share}
            cp document.tex $out/share/document.tex
            cp settings.sty $out/share/settings.sty
            cp employment.tex $out/share/employment.tex
            cp education.tex $out/share/education.tex
            cp publications.tex $out/share/publications.tex
            cp own-bib.bib $out/share/own-bib.bib
            cp skills.tex $out/share/skills.tex
            cp misc.tex $out/share/misc.tex
            cp referee.tex $out/share/referee.tex
            cp photo.jpg $out/share/photo.jpg
            cp latex-demo-document $out/bin/latex-demo-document
            chmod u+x $out/bin/latex-demo-document
          '';
        };
      };
      defaultPackage = packages.document;
    });
}
