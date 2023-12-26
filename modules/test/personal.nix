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
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../components/personal.nix];
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
        personal = {
          basic = {
            name = "John Doe";
            label = "Programmer";
            email = "john@doe.com";
            phone = "(123) 456-7890";
            url = "https://john.doe.com";
            location = {
              street = "123 Nunya Drive Unit 42";
              city = "Clinton";
              state = "MI";
              country = "USA";
              postalCode = "64735";
            };
            profiles = {
              socials = [
                {
                  url = "https://github.com/jdoe";
                }
                {
                  url = "https://mastodon.com/@jdoe";
                }
              ];
            };
          };
        };
      };
    };
  };
}
