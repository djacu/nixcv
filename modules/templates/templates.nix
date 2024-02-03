{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  modulesLib = import ../../lib/modules.nix {inherit lib;};
in {
  options = {
    templates = lib.mkOption {
      description = "FIXME";
      #visible = "shallow";
      type = types.submodule {
        imports = [
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
                ../components/rawlatex.nix
              ];
              ordered = false;
            }
          )
        ];

        options = {
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
      };
    };

    _out = {
      templates = lib.mkOption {
        description = "This modules template output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };

  config = {
    _out = {
      templates =
        if (! builtins.isNull cfg.templates.templateFile)
        then builtins.readFile cfg.templates.templateFile
        else
          (
            lib.concatStringsSep
            "\n\n"
            [
              cfg.templates.layout._out.latex
              cfg.templates.enumitem._out.latex
              (
                lib.concatStringsSep
                "\n\n"
                (
                  []
                  ++ (cfg.templates.environmentsOutOrdered "latex")
                  ++ (cfg.templates.titlesecOutOrdered "latex")
                  ++ (cfg.templates.latexOutOrdered "latex")
                )
              )
            ]
          );
    };
  };
}
