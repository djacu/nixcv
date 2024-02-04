{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      item = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/lists/item.nix
          [
            "basic"
            "formatted"
          ]
        );
      };
    };
  };
  config = {
    test = {
      item = rec {
        basic = {
          content = "I write a lot of nix!";
        };
        formatted =
          basic
          // {
            format = {
              size = "LARGE";
            };
          };
      };
    };
  };
}
