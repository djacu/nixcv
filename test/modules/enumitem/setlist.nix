{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      setlist = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/enumitem/setlist.nix
          [
            "minimal"
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      setlist = {
        minimal = {
          name = "skills";
        };
        basic = {
          name = "skills";
          levels = [1 2];
          label = ''\textbullet'';
        };
      };
    };
  };
}
