{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      profiles = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/components/profiles.nix
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
      profiles = rec {
        basic = {
          profiles = {
            github = {
              network = "github";
              url = "https://github.com/jdoe";
            };
            linkedin = {
              network = "linkedin";
              url = "https://linkedin.com/in/jdoe";
            };
            mastodon = {
              network = "mastodon";
              url = "https://mastodon.com/@jdoe";
            };
            personal = {
              network = "user";
              url = "https://jdoe.dev";
            };
            other = {
              url = "https://some.site/jdoe";
            };
          };
        };
        order =
          basic
          // {
            profileOrder = [
              "github"
              "linkedin"
              "personal"
            ];
          };
      };
    };
  };
}
