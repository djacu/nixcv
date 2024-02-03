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
          ../templates/misc.nix
          #(
          #  import
          #  ../components/taggedName.nix
          #  {
          #    name = "misc";
          #    submodules = [
          #      ../templates/newenvironment.nix
          #      ../enumitem/enumitem.nix
          #      ../components/rawlatex.nix
          #      ../titlesec/titleformat.nix
          #    ];
          #    ordered = false;
          #  }
          #)
        ];

        options = {
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
      templates = (
        lib.concatStringsSep
        "\n\n"
        [
          cfg.templates.layout._out.latex
          cfg.templates.enumitem._out.latex
          (
            lib.concatStringsSep
            "\n\n"
            (cfg.templates.miscOutOrdered "latex")
          )
        ]
      );
    };
  };
}
