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
    type = lib.mkOption {
      type = lib.types.enum ["section"];
      default = "section";
      description = "Type";
      internal = true;
    };
    header = lib.mkOption {
      description = "The section header.";
      type = types.nullOr types.str;
      default = null;
      example = "Experience";
    };
    content = lib.mkOption {
      description = "The content of this section.";
      type = types.nullOr (types.attrsOf (
        modulesLib.taggedSubmodules {
          types = {
            itemlist = types.submodule ../lists/itemlist.nix;
            paragraphs = types.submodule ../text/paragraphs.nix;
            skills = types.submodule ../skills/skills.nix;
          };
        }
      ));
      default = null;
    };

    order = lib.mkOption {
      description = "The order in which the contents are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    _out = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.listOf types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };
  config = {
    _out = let
      contentsOrdered =
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
          contentsOrdered
        );
      wrapLatex = input: (
        lib.flatten
        [
          "" # white space helps with reading the latex output
          "\\section{${cfg.header}}"
          (
            builtins.map
            (x: "  " + x)
            input
          )
        ]
      );
    in {
      plaintext = "";
      latex = wrapLatex (outOrdered "latex");
    };
  };
}
