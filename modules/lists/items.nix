{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/format.nix
    ../components/orderedContent.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["items"];
      default = "items";
      description = "Type";
      internal = true;
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
        (x: "\\item {${cfg.applyFormat x}}")
        cfg.contentsOrdered;
    };
  };
}
