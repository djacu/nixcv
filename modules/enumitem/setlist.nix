{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardStringOut.nix
    ./setlistOptions.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["setlist"];
      default = "setlist";
      description = "Type";
      internal = true;
    };
    name = lib.mkOption {
      description = "The name of the list to modify.";
      type = types.str;
      example = "mylist";
    };
    levels = lib.mkOption {
      description = "The levels of the list to modify. 0 means 'all levels'.";
      # By default, LaTeX has a limit of 5 nesting levels.
      type = types.listOf (types.ints.between 0 5);
      default = [0];
      defaultText = lib.literalExpression "[0]";
      example = lib.literalExpression "[1 2]";
    };
    label = lib.mkOption {
      description = "The label for the declared level of the list.";
      type = types.str;
      default = "";
      example = lib.literalExpression "''\\textbullet''";
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        ""
        [
          ''\setlist''
          "["
          "${cfg.name}"
          ","
          (lib.concatMapStringsSep "," builtins.toString cfg.levels)
          "]"
          "{"
          (
            lib.concatStringsSep
            ", "
            (
              lib.remove
              ""
              [
                "label={${cfg.label}}"
                "${cfg.format._out.latex}"
              ]
            )
          )
          "}"
        ];
    };
  };
}
