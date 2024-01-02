{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        skills = lib.mkOption {
          description = "A skill entry.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../../sections/skills.nix];
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
        skills = {
          basic = {
            skills = {
              web-dev = {
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
              };
              nix-dev = {
                label = "Nix Development";
                keywords = ["Nixpkgs" "NixOS" "Modules"];
              };
              random = {
                label = "Random";
                keywords = ["Random" "Things" "I" "Like"];
                keywordsSep = ".";
              };
            };
          };
        };
      };
    };
  };
}
