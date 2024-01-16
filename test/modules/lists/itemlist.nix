{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      itemlist = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/lists/itemlist.nix
          [
            "basic"
            "items"
            "nested"
          ]
        );
      };
    };
  };
  config = {
    test = {
      itemlist = {
        basic = {
          content = {
            i-love-nix = {
              type = "item";
              content = "I really love nix!.";
            };
          };
        };
        items = {
          content = {
            i-love-nix = {
              type = "items";
              content = [
                "I really love nix!."
                "You don't seem to understand."
              ];
            };
          };
        };
        nested = {
          order = [
            "name"
            "details"
          ];
          content = {
            name = {
              type = "item";
              content = "Jane Doe";
              format = {
                size = "large";
                bold = true;
              };
            };

            details = {
              type = "itemlist";
              order = [
                "organization"
                "phone"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "Another Company";
                  format = {
                    bold = true;
                  };
                };
                phone = {
                  type = "item";
                  content = "098.765.4321";
                };
              };
            };
          };
        };
      };
    };
  };
}
