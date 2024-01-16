{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      profile = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/lists/profile.nix
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
      profile = rec {
        basic = {
          content = "github.com/jdoe";
          icon = "github";
        };
        formatted =
          basic
          // {
            format = {
              size = "large";
            };
          };
      };
    };
  };
}
