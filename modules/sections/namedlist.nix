{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["namedlist"];
      default = "namedlist";
      internal = true;
      description = "Type";
    };
    name = lib.mkOption {
      description = "A name/header for the list items.";
      type = types.nullOr types.str;
      default = null;
      example = "Personal";
    };
    nameSep = lib.mkOption {
      description = "The separator between the `name` and `items`.";
      type = types.str;
      default = "\n";
      example = "\n";
    };
    label = lib.mkOption {
      description = "A label for the list items.";
      type = types.nullOr types.str;
      default = null;
      example = "•";
    };
    labelSep = lib.mkOption {
      description = "The separator between the `label` and `items`.";
      type = types.nullOr types.str;
      default = " ";
      example = " ";
    };
    items = lib.mkOption {
      description = "A label for the list items.";
      type = types.nullOr (types.either (types.listOf types.str) (types.attrsOf types.str));
      default = null;
      example = "•";
    };
    itemsSep = lib.mkOption {
      description = "The separator between `items`.";
      type = types.str;
      default = "\n";
      example = "\n";
    };
    _out.namedlist = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out.namedlist = {
      plaintext = let
        parsedItems = (
          if (builtins.typeOf cfg.items == "set")
          then builtins.attrValues cfg.items
          else if (builtins.typeOf cfg.items == "list")
          then cfg.items
          else null
        );
        concatLabels =
          if (! builtins.isNull cfg.label)
          then
            (
              builtins.map
              (
                x:
                  utils.concatStringsSepFiltered
                  cfg.labelSep
                  null
                  [
                    cfg.label
                    x
                  ]
              )
              parsedItems
            )
          else parsedItems;
        concatItems =
          utils.concatStringsSepFiltered
          cfg.itemsSep
          null
          concatLabels;
        concatNames =
          utils.concatStringsSepFiltered
          cfg.nameSep
          null
          [cfg.name concatItems];
      in
        concatNames;
    };
  };
}
