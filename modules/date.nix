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
      description = "This modules output.";
      type = types.str;
    };
    monthFormat = lib.mkOption {
      description = "The month format.";
      type = types.enum ["int" "short" "long"];
      default = "int";
    };
    monthLanguage = lib.mkOption {
      description = "The language to use for months as words.";
      type = types.str;
      default = "english";
    };
    _months = lib.mkOption {
      description = "Short and long month names by language.";
      type = types.attrsOf (types.submodule {
        options = {
          short = lib.mkOption {
            description = "Months short name.";
            type = types.attrsOf types.str;
          };
          long = lib.mkOption {
            description = "Months long name.";
            type = types.attrsOf types.str;
          };
        };
      });
    };
  };
  config = {
    _months = {
      english = {
        short = {
          "1" = "Jan.";
          "2" = "Feb.";
          "3" = "Mar.";
          "4" = "Apr.";
          "5" = "May";
          "6" = "Jun.";
          "7" = "Jul.";
          "8" = "Aug.";
          "9" = "Sep.";
          "10" = "Oct.";
          "11" = "Nov.";
          "12" = "Dec.";
        };
        long = {
          "1" = "January";
          "2" = "February";
          "3" = "March";
          "4" = "April";
          "5" = "May";
          "6" = "June";
          "7" = "July";
          "8" = "August";
          "9" = "September";
          "10" = "October";
          "11" = "November";
          "12" = "December";
        };
      };
    };
    out =
      if ! builtins.isNull cfg.rawStr
      then cfg.rawStr
      else if cfg.monthFormat == "int"
      then let
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
        )
      else
        # FIXME: fails if month is not declared
        lib.concatStringsSep
        " "
        (
          builtins.filter
          (x: ! builtins.isNull x)
          [
            (cfg._months.${cfg.monthLanguage}.${cfg.monthFormat}.${builtins.toString cfg.month})
            (
              if (! builtins.isNull cfg.day)
              then builtins.toString cfg.day + ","
              else null
            )
            (
              if (! builtins.isNull cfg.year)
              then builtins.toString cfg.year
              else null
            )
          ]
        );
  };
}
