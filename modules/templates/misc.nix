{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  contentName = "misc";
in {
  imports = [
    (
      import
      ../components/taggedName.nix
      {
        name = contentName;
        submodules = [
          ../templates/newenvironment.nix
          ../titlesec/titleformat.nix
          ../enumitem/enumitem.nix
          ../components/rawlatex.nix
        ];
        ordered = false;
      }
    )
  ];

  options = {
    templateFile = lib.mkOption {
      description = "A LaTeX template that precedes any options defined in `template`.";
      type = types.path;
      default = ../../latex/cv.tex;
    };

    _out = {
      template = lib.mkOption {
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
      template = (
        lib.concatStringsSep
        "\n\n"
        (
          [
            (builtins.readFile cfg.templateFile)
          ]
          ++ (cfg."${contentName}OutOrdered" "latex")
        )
      );
    };
  };
}
