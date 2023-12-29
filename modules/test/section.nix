{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        skillsSection = lib.mkOption {
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
        skillsSection = {
          basic = {
            header = "Skills";
            content = {
              web-dev = {
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
              };
              nix-dev = {
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
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
                sep = " - ";
              };
              nix-dev = {
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
                label = "Web Development";
                keywords = ["HTML" "CSS" "JavaScript"];
              };
              nix-dev = {
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
