{
  lib,
  config,
  options,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ./utils.nix {inherit lib;};
in {
  options = {
    day = lib.mkOption {
      description = "The day.";
      type = types.nullOr (types.ints.between 1 31);
      default = null;
      example = "1";
    };
    month = lib.mkOption {
      description = "The month.";
      type = types.nullOr (types.ints.between 1 12);
      default = null;
      example = "1";
    };
    year = lib.mkOption {
      description = "The year.";
      type = types.nullOr types.ints.positive;
      default = null;
      example = "1970";
    };
    userStr = lib.mkOption {
      description = ''
        A user override of the date output.
        Use this if you want to specify your date as a string.
      '';
      type = types.nullOr types.str;
      default = null;
      example = "1970/01/01";
    };
    sep = lib.mkOption {
      description = "The separator between the year, month, and day.";
      type = types.str;
      default = "/";
      example = ".";
    };
    order = lib.mkOption {
      description = "The order to display the year, month, and day.";
      type = types.enum (utils.permutationsConcat ["y" "m" "d"]);
      default = "ymd";
      example = "dmy";
    };
    monthFormat = lib.mkOption {
      description = ''
        The month format.
        `int` will use the integer value of the month.
        `short` and `long` will use the respective month name declared in `_months` depending on the language set in `monthLanguage`.
      '';
      type = types.enum ["int" "short" "long"];
      default = "int";
      example = "long";
    };
    monthLanguage = lib.mkOption {
      description = ''
        The language to use for the month if `monthFormat` is set to `short` or `long`.
        Currently only these languages are built in: ${lib.concatStringsSep ", " (builtins.attrNames cfg._months)}.
      '';
      type = types.str;
      default = "english";
      example = "spanish";
    };
    _months = lib.mkOption {
      description = ''
        Short and long month names by language.
        Used with `monthFromat` and `monthLanguage`.
        If you need a language that is not provided, override `_months` in your config.
      '';
      visible = "shallow";
      example = lib.literalExpression ''
        {
          english = {
            short = {
              "1" = "Jan.";
              "2" = "Feb.";
              "3" = "Mar.";
              "4" = "Apr.";
              "5" = "May";
              "6" = "June";
              "7" = "July";
              "8" = "Aug.";
              "9" = "Sept.";
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
        }
      '';
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
    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = {
    _months = {
      english = {
        short = {
          "1" = "Jan";
          "2" = "Feb";
          "3" = "Mar";
          "4" = "Apr";
          "5" = "May";
          "6" = "June";
          "7" = "July";
          "8" = "Aug";
          "9" = "Sept";
          "10" = "Oct";
          "11" = "Nov";
          "12" = "Dec";
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
      spanish = {
        short = {
          "1" = "Enero";
          "2" = "Feb";
          "3" = "Marzo";
          "4" = "Abr";
          "5" = "Mayo";
          "6" = "Jun";
          "7" = "Jul";
          "8" = "Agosto";
          "9" = "Sep";
          "10" = "Oct";
          "11" = "Nov";
          "12" = "Dic";
        };
        long = {
          "1" = "Enero";
          "2" = "Febrero";
          "3" = "Marzo";
          "4" = "Abril";
          "5" = "Mayo";
          "6" = "Junio";
          "7" = "Julio";
          "8" = "Agosto";
          "9" = "Septiembre";
          "10" = "Octubre";
          "11" = "Noviembre";
          "12" = "Diciembre";
        };
      };
      french = {
        short = {
          "1" = "Janv";
          "2" = "Févr";
          "3" = "Mars";
          "4" = "Avr";
          "5" = "Mai";
          "6" = "Juin";
          "7" = "Juil";
          "8" = "Août";
          "9" = "Sept";
          "10" = "Oct";
          "11" = "Nov";
          "12" = "Déc";
        };
        long = {
          "1" = "Janvier";
          "2" = "Février";
          "3" = "Mars";
          "4" = "Avril";
          "5" = "Mai";
          "6" = "Juin";
          "7" = "Juillet";
          "8" = "Août";
          "9" = "Septembre";
          "10" = "Octobre";
          "11" = "Novembre";
          "12" = "Décembre";
        };
      };
    };
    _outPlaintext =
      if ! builtins.isNull cfg.userStr
      then cfg.userStr
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
      else if (builtins.isNull cfg.month)
      then let
        parents = utils.getSubmoduleParents options;
      in
        throw ''
          Value of ${parents}.month is not defined but ${parents}.monthFormat is set to "${cfg.monthFormat}".
          Change monthFormat to "int" or set a value for month.''
      else
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
