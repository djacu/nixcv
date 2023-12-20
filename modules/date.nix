{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
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
    out = lib.mkOption {
      type = types.str;
    };
  };
  config = {
    out = let
      parsedDate =
        lib.concatStringsSep
        cfg.sep
        (
          builtins.map
          builtins.toString
          (
            builtins.filter
            (x: ! builtins.isNull x)
            [cfg.year cfg.month cfg.day]
          )
        );
    in
      if builtins.isNull cfg.rawStr
      then parsedDate
      else cfg.rawStr;
  };
}
