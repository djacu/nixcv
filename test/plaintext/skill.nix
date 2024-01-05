{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      skill = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/components/skill.nix
          [
            "basic"
            "labelSep"
            "keywordsSep"
          ]
        );
      };
    };
  };
  config = {
    test = {
      skill = {
        basic = {
          label = "Web Development";
          keywords = ["HTML" "CSS" "JavaScript"];
        };
        labelSep = {
          label = "Web Development";
          keywords = ["HTML" "CSS" "JavaScript"];
          labelSep = " - ";
        };
        keywordsSep = {
          label = "Web Development";
          keywords = ["HTML" "CSS" "JavaScript"];
          keywordsSep = " - ";
        };
      };
    };
  };
}
