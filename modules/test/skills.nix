{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        skill = lib.mkOption {
          description = "A skill entry.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "sep"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../skill.nix];
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
        skill = {
          basic = {
            label = "Web Development";
            keywords = ["HTML" "CSS" "JavaScript"];
          };
          sep = {
            label = "Web Development";
            keywords = ["HTML" "CSS" "JavaScript"];
            sep = " - ";
          };
        };
      };
    };
  };
}
