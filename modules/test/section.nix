{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
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
                    modules = [../section.nix];
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
      skillsSection = {
        basic = {
          header = "Skills";
          content = [
            {
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
            }
            {
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
            }
          ];
          _module.args = {modules = [../skill.nix];};
        };
        sep = {
          header = "Skills";
          content = [
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
          _module.args = {modules = [../skill.nix];};
          sep = "; ";
        };
        headerFunc = {
          header = "Skills";
          headerFunc = lib.toUpper;
          content = [
            {
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
            }
            {
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
            }
          ];
          _module.args = {modules = [../skill.nix];};
        };
      };
    };
  };
}
