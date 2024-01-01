{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        paragraphs = lib.mkOption {
          description = "A paragraphs entry.";
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
                      modules = [../sections/paragraphs.nix];
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
        paragraphs = rec {
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
              sep = "\n---\n";
            };
        };
      };
    };
  };
}
