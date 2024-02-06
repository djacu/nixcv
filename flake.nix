{
  description = "LaTeX Document Demo";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.flake-utils.follows = "flake-utils";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    poetry2nix,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      inherit
        (poetry2nix.lib.mkPoetry2Nix {inherit pkgs;})
        mkPoetryEnv
        ;

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

      packagingLib = import ./lib/packaging.nix {
        inherit pkgs tex;
        directory = ./.;
      };

      documentationLib = import ./lib/documentation.nix {inherit self pkgs lib;};
      examplesLib = import ./lib/examples.nix {inherit self system pkgs lib;};

      moduleMarkdownDocs = documentationLib.generateMarkdownDocumentation {};
      examplePdfDocs = examplesLib.generateExamplesDocumentation {};

      site-env = mkPoetryEnv {
        projectDir = self + /site;
        python = pkgs.python311;
      };

      site = pkgs.stdenvNoCC.mkDerivation {
        name = "nixcv-site";
        src = self + "/site";
        nativeBuildInputs = [site-env];

        buildPhase = ''
          cp -r ${moduleMarkdownDocs}/* ./docs/documentation/
          cp -r ${examplePdfDocs}/* ./docs/
          ls -FhoAR
          mkdocs build --site-dir dist
        '';
        installPhase = ''
          mkdir $out
          cp -R dist/* $out/
        '';
      };
    in {
      devShells = {
        poetry = pkgs.mkShell {
          packages = [
            pkgs.poetry
            pkgs.python311
          ];
        };
        site = pkgs.mkShell {
          buildInputs = [
            pkgs.poetry
            site-env
          ];
        };
      };
      packages =
        {
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
              cp ./old/document.tex $out/share/document.tex
              cp ./old/cv.tex $out/share/cv.tex
              cp ./old/self.bib $out/share/self.bib
              cp latex-demo-document $out/bin/latex-demo-document
              chmod u+x $out/bin/latex-demo-document
            '';
          };
        }
        // packagingLib.examples
        // {
          inherit
            moduleMarkdownDocs
            examplePdfDocs
            site
            ;
        };

      apps = {
        copyMarkdownDocs = {
          type = "app";
          program = "${documentationLib.copyMarkdownDocs}/bin/copy-markdown-docs";
        };
        copyExampleDocs = {
          type = "app";
          program = "${examplesLib.copyExampleDocs}/bin/copy-example-docs";
        };
      };

      extra = {
        evaluatedModules = documentationLib.evaluatedModules {};
      };

      checks =
        {}
        // packagingLib.examples
        // {
          inherit
            moduleMarkdownDocs
            examplePdfDocs
            ;
        };

      test = lib.listToAttrs (
        builtins.map
        (
          file:
            lib.nameValuePair
            (lib.removeSuffix ".nix" file)
            (import ./test/${file} {inherit lib;})
        )
        (
          builtins.attrNames (
            lib.filterAttrs
            (name: value: value == "regular")
            (builtins.readDir ./test)
          )
        )
      );
    })
    // {
      nixosModules.templates.simple = ./templates/simple.nix;
    };
}
