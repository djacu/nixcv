{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ./utils.nix {inherit lib;};
in {
  options = {
    day = lib.mkOption {
      description = "The day.";
      type = types.nullOr (types.numbers.between 1 31);
      default = null;
      defaultText = "1";
    };
    month = lib.mkOption {
      description = "The month.";
      type = types.nullOr (types.numbers.between 1 12);
      default = null;
      defaultText = "1";
    };
    year = lib.mkOption {
      description = "The year.";
      type = types.nullOr types.numbers.positive;
      default = null;
      defaultText = "1970";
    };
    rawStr = lib.mkOption {
      description = "A date string with no formatting.";
      type = types.nullOr types.str;
      default = null;
      defaultText = "1970/01/01";
    };
    sep = lib.mkOption {
      description = "The date separator.";
      type = types.str;
      default = "/";
    };
    order = lib.mkOption {
      description = "The order to display the year, month, and day.";
      type = types.enum (utils.permutationsConcat ["y" "m" "d"]);
      default = "ymd";
    };
    out = lib.mkOption {
      type = types.str;
    };
  };
  config = {
    out = let
      parsedDate = let
        lookup = {
          d = cfg.day;
          m = cfg.month;
          y = cfg.year;
        };
      in
        lib.concatStringsSep
        cfg.sep
        (
          builtins.map
          builtins.toString
          (
            builtins.filter
            (x: ! builtins.isNull x)
            (
              builtins.map
              (x: lookup.${x})
              (lib.stringToCharacters cfg.order)
            )
          )
        );
    in
      if builtins.isNull cfg.rawStr
      then parsedDate
      else cfg.rawStr;
  };
}
