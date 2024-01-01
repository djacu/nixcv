{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        date = lib.mkOption {
          description = "A single date.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "separator"
                "order"
                "userStr"
                "monthLong"
                "monthShort"
                "monthLanguage"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../components/date.nix];
                    };
                  }
              )
            );
          };
        };
        dates = lib.mkOption {
          description = "A date range.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "empty"
                "basic"
                "separator"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../components/dateRange.nix];
                    };
                  }
              )
            );
          };
        };
      };
    };
  };
  config = {
    nixcv = {
      test = {
        date = {
          basic = {
            year = 2021;
            month = 11;
            day = 4;
          };
          separator = {
            year = 2021;
            month = 11;
            day = 4;
            sep = ".";
            order = "dmy";
          };
          order = {
            year = 2021;
            month = 11;
            day = 4;
            order = "dmy";
          };
          userStr = {
            userStr = "I can write anything!";
          };
          monthLong = {
            year = 2021;
            month = 11;
            day = 4;
            monthFormat = "long";
          };
          monthShort = {
            year = 2021;
            month = 11;
            day = 4;
            monthFormat = "short";
          };
          monthLanguage = {
            year = 2023;
            month = 12;
            day = 14;
            monthLanguage = "blah";
            monthFormat = "long";
            _months.blah = {
              short = {
                "1" = "xxx.";
                "2" = "xxx.";
                "3" = "xxx.";
                "4" = "xxx.";
                "5" = "xxx";
                "6" = "xxx.";
                "7" = "xxx.";
                "8" = "xxx.";
                "9" = "xxx.";
                "10" = "xxx.";
                "11" = "xxx.";
                "12" = "xxx.";
              };
              long = {
                "1" = "YYYJanuary";
                "2" = "YYYFebruary";
                "3" = "YYYMarch";
                "4" = "YYYApril";
                "5" = "YYYMay";
                "6" = "YYYJune";
                "7" = "YYYJuly";
                "8" = "YYYAugust";
                "9" = "YYYSeptember";
                "10" = "YYYOctober";
                "11" = "YYYNovember";
                "12" = "YYYDecember";
              };
            };
          };
        };
        dates = {
          empty = {};
          basic = {
            start = {
              year = 2021;
              month = 11;
              day = 4;
            };
            end = {
              year = 2022;
              month = 7;
              day = 16;
            };
          };
          separator = {
            start = {
              year = 2021;
              month = 11;
              day = 4;
            };
            end = {
              year = 2022;
              month = 7;
              day = 16;
            };
            sep = " to ";
          };
        };
      };
    };
  };
}
