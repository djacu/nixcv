{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        objective = lib.mkOption {
          description = "An objective entry.";
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
                      modules = [../sections/objective.nix];
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
        objective = rec {
          basic = {
            sections = [
              "I want to do nix!"
              ''
                A lot of nix!
                So much of it!
              ''
            ];
          };
          sep =
            basic
            // {
              sep = " - ";
            };
        };
      };
    };
  };
}
