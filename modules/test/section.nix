{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        skillSection = lib.mkOption {
          description = "A references entry.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "sep"
                "headerFunc"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../sections/section.nix];
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
        skillSection = {
          basic = {
            header = "Skills";
            content = {
              web-dev = {
                type = "skill";
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
              };
              nix-dev = {
                type = "skill";
                label = "Nix Development";
                keywords = ["Nixpkgs" "NixOS" "Modules"];
              };
            };
            _module.args = {modules = [../sections/skill.nix];};
          };
          sep = {
            header = "Skills";
            content = {
              web-dev = {
                type = "skill";
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
                sep = " - ";
              };
              nix-dev = {
                type = "skill";
                label = "Nix Development";
                keywords = ["Nixpkgs" "NixOS" "Modules"];
                sep = " - ";
              };
            };
            _module.args = {modules = [../sections/skill.nix];};
            sep = "; ";
          };
          headerFunc = {
            header = "Skills";
            headerFunc = lib.toUpper;
            content = {
              web-dev = {
                type = "skill";
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
              };
              nix-dev = {
                type = "skill";
                label = "Nix Development";
                keywords = ["Nixpkgs" "NixOS" "Modules"];
              };
            };
            _module.args = {modules = [../sections/skill.nix];};
          };
        };
      };
    };
  };
}
