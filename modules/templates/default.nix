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
      description = "Template configuration for the LaTeX output.";
      #visible = "shallow";
      type = types.submodule {
        imports = [
          (
            import
            ../components/taggedContent.nix
            {
              submodules = [
                ../templates/templates.nix
              ];
            }
          )
        ];

        options = {
          layout = lib.mkOption {
            description = "Defines the document class and basic paper/text styles.";
            type = modulesLib.pathsToTaggedSubmodules [
              ../templates/layout.nix
            ];
            default = {
              type = "layout";
            };
          };

          templateFile = lib.mkOption {
            description = "A LaTeX template file. Will be used instead of any module settings.";
            type = types.nullOr types.path;
            default = null;
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
          lib.concatStringsSep
          "\n\n"
          [
            cfg.templates.layout._out.latex
            (
              lib.concatStringsSep
              "\n\n"
              (cfg.templates.outOrdered "latex")
            )
          ];
    };
  };
}
