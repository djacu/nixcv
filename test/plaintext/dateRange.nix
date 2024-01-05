{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      dateRange = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/components/dateRange.nix
          [
            "basic"
            "separator"
          ]
        );
      };
    };
  };
  config = {
    test = {
      dateRange = rec {
        basic = {
          start = {
            day = 1;
            month = 2;
            year = 3456;
          };
          end = {
            day = 11;
            month = 12;
            year = 4567;
          };
        };
        separator =
          basic
          // {
            sep = " -- ";
          };
      };
    };
  };
}
