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
    content = lib.mkOption {
      description = "The sections of the CV.";
      type = types.attrsOf (
        modulesLib.taggedSubmodules {
          types = {
            personal = types.submodule ./personal.nix;
            section = types.submodule ./section.nix;
          };
        }
      );
      visible = "shallow";
    };
    order = lib.mkOption {
      description = "The order the sections are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    _out = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out = let
      sectionsOrdered =
        if builtins.isNull cfg.order
        then builtins.attrValues cfg.content
        else
          (
            builtins.map
            (elem: cfg.content.${elem})
            cfg.order
          );

      outOrdered = out:
        lib.flatten (
          builtins.map
          (x: x._out.${out})
          sectionsOrdered
        );
      wrapLatex = input:
        lib.concatStringsSep
        "\n"
        (
          lib.flatten
          [
            "\\begin{document}"
            (
              builtins.map
              (x: "  " + x)
              input
            )
            "\\end{document}"
          ]
        );
    in {
      plaintext = "";
      latex = wrapLatex (outOrdered "latex");
    };
  };
}
