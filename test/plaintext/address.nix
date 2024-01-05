{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      address = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/components/address.nix
          [
            "basic"
            "format"
            "separator"
          ]
        );
      };
    };
  };
  config = {
    test = {
      address = {
        basic = {
          street = "123 Nunya Drive Unit 42";
          city = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
        };
        format = {
          street = "123 Nunya Drive Unit 42";
          town = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
          format = [
            "street"
            "town"
            "state"
            "country"
            "postalCode"
          ];
        };
        separator = {
          street = "123 Nunya Drive Unit 42";
          city = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
          sep = "\n";
        };
      };
    };
  };
}
