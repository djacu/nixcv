{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      paragraphs = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/sections/paragraphs.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      paragraphs = {
        basic = {
          paragraphs = {
            intro = "I want to do nix!";
            more = ''
              A lot of nix!
              So much of it!
            '';
          };
        };
      };
    };
  };
}
