{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      personal = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/sections/personal.nix
          [
            "basic"
            "order"
          ]
        );
      };
    };
  };
  config = {
    test = {
      personal = rec {
        basic = {
          type = "personal";
          name = "John Doe";
          label = "Programmer";
          email = "john@doe.com";
          phone = "(123) 456-7890";
          address = {
            street = "123 Nunya Drive Unit 42";
            city = "Clinton";
            state = "MI";
            country = "USA";
            postalCode = "64735";
          };
          profiles = {
            github = {
              url = "https://github.com/jdoe";
            };
            mastodon = {
              url = "https://mastodon.com/@jdoe";
            };
          };
        };
        order =
          basic
          // {
            order = [
              "name"
              "label"
              "phone"
              "email"
              "profiles"
            ];
          };
      };
    };
  };
}
