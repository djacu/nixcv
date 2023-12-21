{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      date = lib.mkOption {
        description = "Your CV.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "separator" "order" "rawStr" "monthLong" "monthShort" "monthLanguage"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./date.nix];};})
          );
        };
      };
    };
  };
  config = {
    nixcv = {
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
        rawStr = {
          rawStr = "I can write anything!";
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
    };
  };
}
