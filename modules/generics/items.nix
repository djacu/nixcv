{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["items"];
      default = "items";
      description = "Type";
      internal = true;
    };
    content = lib.mkOption {
      description = "A list of list items.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };
    format = lib.mkOption {
      description = "Formatting applied to the LaTeX output.";
      type = types.nullOr (types.attrsOf (types.oneOf [types.str types.bool]));
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
    _out = {
      plaintext = "";
      latex =
        builtins.map
        (x: "\\item ${x}")
        cfg.content;
    };
  };
}
