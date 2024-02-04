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
          ]
        );
      };
    };
  };
  config = {
    test = {
      personal = {
        basic = {
          order = [
            "name"
            "title"
            "socials"
          ];
          content = {
            name = {
              type = "text";
              content = "John Doe";
              format = {
                bold = true;
                size = "Huge";
              };
            };
            title = {
              type = "text";
              content = "Software Developer";
              format = {
                size = "Large";
              };
            };

            socials = {
              type = "itemlist";
              order = [
                "location"
                "phone"
                "github"
              ];
              content = {
                location = {
                  type = "profile";
                  content = "Nunya, USA";
                  icon = "map-marker-alt";
                };
                phone = {
                  type = "profile";
                  content = "123.456.7890";
                  icon = "phone-alt";
                };
                github = {
                  type = "profile";
                  content = "github.com/jdoe";
                  icon = "github";
                };
              };
            };
          };
        };
      };
    };
  };
}
