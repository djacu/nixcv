{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
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
      skills = lib.mkOption {
        description = "A skills entry.";
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
                    modules = [../skills.nix];
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
      skills = {
        basic = {
          skills = [
            {
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
            }
            {
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
            }
          ];
        };
        sep = {
          skills = [
            {
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
              sep = " - ";
            }
            {
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
              sep = " - ";
            }
          ];
          sep = "; ";
        };
      };
    };
  };
}
