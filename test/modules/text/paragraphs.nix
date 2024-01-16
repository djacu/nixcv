{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      paragraphs = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/text/paragraphs.nix
          [
            "list"
            "set"
            "setOrdered"
          ]
        );
      };
    };
  };
  config = {
    test = {
      paragraphs = {
        list = {
          content = [
            "A lot of nix!"
            "So much of it!"
          ];
        };
        set = {
          content = {
            a = "A lot of nix!";
            b = "So much of it!";
          };
        };
        setOrdered = {
          order = [
            "b"
            "a"
          ];
          content = {
            a = "A lot of nix!";
            b = "So much of it!";
          };
        };
      };
    };
  };
}
