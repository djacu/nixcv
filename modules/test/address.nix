{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        address = lib.mkOption {
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "format"
                "separator"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../components/address.nix];
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
        address = {
          basic = {
            street = "123 Nunya Drive Unit 42";
            city = "Clinton";
            state = "MI";
            country = "USA";
            postalCode = "64735";
          };
          format = {
            street = "123 Nunya Drive Unit 42";
            town = "Clinton";
            state = "MI";
            country = "USA";
            postalCode = "64735";
            format = [
              "street"
              "town"
              "state"
              "country"
              "postalCode"
            ];
          };
          separator = {
            street = "123 Nunya Drive Unit 42";
            city = "Clinton";
            state = "MI";
            country = "USA";
            postalCode = "64735";
            sep = "\n";
          };
        };
      };
    };
  };
}
