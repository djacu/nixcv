{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      skills = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/skills/skills.nix
          [
            "even"
            "odd"
            "evenOrdered"
            "oddOrdered"
          ]
        );
      };
    };
  };
  config = {
    test = {
      skills = rec {
        even = {
          content = {
            nix-dev = {
              type = "skill";
              category = "Nix Development";
              keywords = [
                "Nix"
                "Nixpkgs"
                "NixOS"
              ];
            };
            web-dev = {
              type = "skill";
              category = "Web Development";
              keywords = [
                "HTML"
                "CSS"
                "JavaScript"
              ];
            };
          };
        };
        odd =
          lib.recursiveUpdate
          even
          {
            content = {
              python-dev = {
                type = "skill";
                category = "Python";
                keywords = [
                  "NumPy"
                  "SciPy"
                  "Pandas"
                ];
              };
            };
          };
        evenOrdered =
          even
          // {
            order = [
              "web-dev"
              "nix-dev"
            ];
          };
        oddOrdered =
          odd
          // {
            order = [
              "python-dev"
              "web-dev"
              "nix-dev"
            ];
          };
      };
    };
  };
}
