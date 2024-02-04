{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      items = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/lists/items.nix
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
      items = rec {
        basic = {
          content = [
            "I write a lot of nix!"
            "Sometimes I write modules."
            "I contribute to nixpkgs."
          ];
        };
        formatted =
          basic
          // {
            format = {
              bold = true;
            };
          };
      };
    };
  };
}
