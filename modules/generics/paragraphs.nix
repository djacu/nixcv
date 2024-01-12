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
    ./format.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["paragraphs"];
      default = "paragraphs";
      description = "Type";
      internal = true;
    };
    content = lib.mkOption {
      description = "A label for the list items.";
      type = types.either (types.listOf types.str) (types.attrsOf types.str);
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
  config = let
    contentsOrdered =
      if (builtins.typeOf cfg.content == "list")
      then cfg.content
      else if builtins.isNull cfg.order
      then builtins.attrValues cfg.content
      else
        (
          builtins.map
          (elem: cfg.content.${elem})
          cfg.order
        );

    wrapLatex = input: (
      lib.flatten
      [
        "\\begin{blockquote}"
        (
          builtins.map
          (x: "  " + x)
          input
        )
        "\\end{blockquote}"
      ]
    );
  in {
    _out = {
      plaintext = "";
      latex = wrapLatex contentsOrdered;
    };
  };
}
