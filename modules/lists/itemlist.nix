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
      type = types.enum ["itemlist"];
      default = "itemlist";
      description = "Type";
      internal = true;
    };
    listname = lib.mkOption {
      type = types.str;
      default = "nolabel";
      description = "The LaTeX list environment name.";
    };
    content = lib.mkOption {
      description = "The content of this itemlist.";
      type = types.nullOr (types.attrsOf (
        modulesLib.taggedSubmodules {
          types = {
            itemlist = types.submodule ./itemlist.nix;
            item = types.submodule ./item.nix;
            items = types.submodule ./items.nix;
            profile = types.submodule ./profile.nix;
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
          "\\begin{${cfg.listname}}"
          (
            builtins.map
            (x: "  " + x)
            input
          )
          "\\end{${cfg.listname}}"
        ]
      );
    in {
      plaintext = "";
      latex = wrapLatex (outOrdered "latex");
    };
  };
}
