{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      skills = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/sections/skills.nix
          [
            "basic"
            "order"
          ]
        );
      };
    };
  };
  config = {
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
        order =
          basic
          // {
            order = ["nix-dev" "web-dev" "random"];
          };
      };
    };
  };
}
