{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      reference = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/sections/reference.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      reference = {
        basic = {
          name = "John Doe";
          organization = "The NixOS Foundation";
          phone = "123.456.7890";
          email = "jdoe@nixos.org";
        };
      };
    };
  };
}
