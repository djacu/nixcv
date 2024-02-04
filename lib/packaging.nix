{
  pkgs,
  tex,
  directory,
}: let
  inherit (pkgs) lib;
in rec {
  examplesDerivations =
    pkgs.lib.mapAttrs'
    (
      name: value: let
        document = pkgs.writeTextFile {
          name = "nixcv-latex-${name}-tex";
          text = value._out.latex;
          destination = "/document.tex";
        };
        bibliography = pkgs.writeTextFile {
          name = "nixcv-latex-${name}-bib";
          text = value._out.bibliography;
          destination = "/bibliography.bib";
        };
        template = pkgs.writeTextFile {
          name = "nixcv-latex-${name}-template";
          text = value._out.templates;
          destination = "/cv.tex";
        };

        newName = "example-${name}";
      in
        lib.nameValuePair
        newName
        (
          pkgs.stdenvNoCC.mkDerivation {
            name = "nixcv-latex-${newName}-files";
            phases = ["installPhase"];

            installPhase = ''
              mkdir -p $out
              cp ${document}/* $out/
              cp ${bibliography}/* $out/
              cp ${template}/* $out/
            '';
          }
        )
    )
    (
      (
        pkgs.lib.evalModules {
          modules =
            [
              (directory + /modules/top/nixcv.nix)
            ]
            ++ (
              builtins.map
              (x: directory + /examples/${x})
              (
                builtins.attrNames (
                  lib.filterAttrs
                  (name: value: value == "regular")
                  (
                    builtins.readDir (directory + /examples)
                  )
                )
              )
            );
        }
      )
      .config
      .nixcv
    );

  examples =
    pkgs.lib.mapAttrs
    (
      name: value:
        pkgs.stdenvNoCC.mkDerivation {
          name = "nixcv-latex-${name}";
          phases = [
            "unpackPhase" # just for fetching the src
            "buildPhase"
            "installPhase"
          ];

          src = value;

          buildInputs = [
            pkgs.biber
            tex
          ];

          buildPhase = ''
            latexmk \
              -interaction=nonstopmode \
              -pdf -pdflatex \
              -output-directory="." \
              document.tex
          '';

          installPhase = ''
            mkdir $out
            cp document.pdf $out/
          '';
        }
    )
    examplesDerivations;
}
