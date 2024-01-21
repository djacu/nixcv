{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      bibliography = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/biblatex/bibliography.nix
          [
            "basic"
            "all-options"
          ]
        );
      };
    };
  };
  config = {
    test = {
      bibliography = {
        basic = {
        };
        all-options = {
          heading = "subbibintoc";
          title = "Talks";
          keyword = "talk";
        };
      };
    };
  };
}
