{lib, ...}: let
  inherit (lib) types;
  listInfo = {
    optionName = "profiles";
    description = "A list of social media profiles.";
    subType = [../../components/socials.nix];
  };
in {
  options = {
    nixcv = {
      test = {
        genericList = lib.mkOption {
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "profileModule"
                "profileModuleSep"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [
                        (import ../../components/genericList.nix listInfo)
                      ];
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
        genericList = {
          profileModule = {
            profiles = [
              {
                url = "https://github.com";
              }
              {
                url = "https://github.com";
              }
            ];
          };
          profileModuleSep = {
            profiles = [
              {
                url = "https://github.com";
              }
              {
                url = "https://github.com";
              }
            ];
            sep = " --- ";
          };
        };
      };
    };
  };
}
