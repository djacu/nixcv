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
          enumitem
          fontaxes
          hyperref
          opensans
          titlesec
          xkeyval
          xcolor
          fontawesome5
          ;
      };

      nixcvEvalModules = pkgs.lib.evalModules {
        # FIXME: Try using special args like `specialArgs = {modules = [ ... ]};
        # Might be able to get section to build properly.
        modules = [
          ./modules/nixcv.nix
          # why is this here?
          # src says "Whether to check whether all option definitions have matching declarations."
          # {_module.check = false;}
        ];
      };
    in {
      packages = {
        document = pkgs.stdenvNoCC.mkDerivation rec {
          name = "latex-demo-document";
          src = self;
          propagatedBuildInputs = [pkgs.coreutils pkgs.biber tex];
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
            cp cv.tex $out/share/cv.tex
            cp self.bib $out/share/self.bib
            cp latex-demo-document $out/bin/latex-demo-document
            chmod u+x $out/bin/latex-demo-document
          '';
        };
      };

      moduleOptions = pkgs.nixosOptionsDoc {
        options = (
          builtins.removeAttrs
          nixcvEvalModules.options
          ["_module"]
        );
      };
    });
}
