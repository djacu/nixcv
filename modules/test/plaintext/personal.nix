{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        personal = lib.mkOption {
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "profiles-ordered"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../../sections/personal.nix];
                    };
                  }
              )
            );
          };
        };
      };
    };
  };
  config = {
    nixcv = {
      test = {
        personal = rec {
          basic = {
            name = "John Doe";
            label = "Programmer";
            email = "john@doe.com";
            phone = "(123) 456-7890";
            location = {
              street = "123 Nunya Drive Unit 42";
              city = "Clinton";
              state = "MI";
              country = "USA";
              postalCode = "64735";
            };
            profiles = {
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
          };
          profiles-ordered =
            lib.recursiveUpdate
            basic
            {
              profiles.order = [
                "linkedin"
                "github"
                "personal"
                "other"
              ];
            };
        };
      };
    };
  };
}
