{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  modulesLib = import ../../lib/modules.nix {inherit lib;};
in {
  imports = [
    ../components/standardStringOut.nix

    (
      import
      ../components/taggedName.nix
      {
        name = "environments";
        submodules = [
          ../templates/newenvironment.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "titlesec";
        submodules = [
          ../titlesec/titleformat.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "latex";
        submodules = [
          ../templates/rawlatex.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "packages";
        submodules = [
          ../templates/packages.nix
        ];
        ordered = false;
      }
    )
  ];

  options = {
    type = lib.mkOption {
      type = types.enum ["templates"];
      default = "templates";
      description = "Type";
      internal = true;
    };

    templateFile = lib.mkOption {
      description = "A LaTeX template file. Will be used instead of any module settings.";
      type = types.nullOr types.path;
      default = null;
    };

    enumitem = lib.mkOption {
      description = "Defines new lists and sets list options.";
      type = modulesLib.pathsToTaggedSubmodules [
        ../enumitem/enumitem.nix
      ];
      default = {
        type = "enumitem";
      };
    };
    layout = lib.mkOption {
      description = "Defines the document class and basic paper/text styles.";
      type = modulesLib.pathsToTaggedSubmodules [
        ../templates/layout.nix
      ];
      default = {
        type = "layout";
        #documentclass = "article";
        #papersize = "letterpaper";
        #textwidth = "7in";
        #textheight = "9in";
        #textsize = "10pt";
        #pagestyle = "empty";
      };
    };
  };

  config = {
    _out = {
      plaintext = "";
      latex =
        if (! builtins.isNull cfg.templateFile)
        then builtins.readFile cfg.templateFile
        else
          (
            lib.concatStringsSep
            "\n\n"
            [
              cfg.layout._out.latex
              cfg.enumitem._out.latex
              (
                lib.concatStringsSep
                "\n\n"
                (
                  []
                  ++ (cfg.packagesOutOrdered "latex")
                  ++ (cfg.environmentsOutOrdered "latex")
                  ++ (cfg.titlesecOutOrdered "latex")
                  ++ (cfg.latexOutOrdered "latex")
                )
              )
            ]
          );
    };
  };
}
