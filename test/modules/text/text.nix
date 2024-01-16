{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      text = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/text/text.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      text = {
        basic = {
          content = "So much text!";
        };
      };
    };
  };
}
