{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      newlist = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/enumitem/newlist.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      newlist = {
        basic = {
          name = "skills";
          parent = "itemize";
          maxDepth = 4;
        };
      };
    };
  };
}
