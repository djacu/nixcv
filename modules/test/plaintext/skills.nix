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
                "ordered"
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
        skills = rec {
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
          ordered =
            basic
            // {
              order = ["nix-dev" "web-dev" "random"];
            };
        };
      };
    };
  };
}
