{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      social = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/components/social.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      social = {
        basic = {
          url = "https://djacu.dev/";
        };
      };
    };
  };
}
