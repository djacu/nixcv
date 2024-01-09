{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      education = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/sections/education.nix
          [
            "basic"
            "enddate"
          ]
        );
      };
    };
  };
  config = {
    test = {
      education = rec {
        enddate = {
          organization = "South Hemet Institute of Technology.";
          discipline = "Software Development";
          credential = "Bachelor of Science";
          address = {
            city = "Hemet";
            state = "CA";
            country = "USA";
          };
          dateRange = {
            start = {
              year = 1977;
              month = 7;
              day = 17;
            };
          };
        };
        basic =
          lib.recursiveUpdate
          enddate
          {
            dateRange.end = {
              year = 1978;
              month = 8;
              day = 18;
            };
          };
      };
    };
  };
}
