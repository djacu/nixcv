{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      education = lib.mkOption {
        description = "An education entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            [
              "empty"
              "basic"
              "endDate"
            ]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [../education.nix];
                  };
                }
            )
          );
        };
      };
    };
  };
  config = {
    nixcv = {
      education = {
        empty = {};
        basic = {
          organization = "South Hemet Institute of Technology.";
          discipline = "Software Development";
          credential = "Bachelor of Science";
          dates = {
            start = {
              year = 1977;
              month = 7;
              day = 17;
            };
            end = {
              year = 1978;
              month = 8;
              day = 18;
            };
          };
        };
        endDate = {
          organization = "South Hemet Institute of Technology.";
          discipline = "Software Development";
          credential = "Bachelor of Science";
          dates = {
            end = {
              year = 1978;
              month = 8;
              day = 18;
            };
          };
        };
      };
    };
  };
}
