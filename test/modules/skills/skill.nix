{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      skill = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/skills/skill.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      skill = {
        basic = {
          category = "Nix Development";
          keywords = [
            "Nix"
            "Nixpkgs"
            "NixOS"
          ];
        };
      };
    };
  };
}
