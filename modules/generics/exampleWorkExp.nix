{
  type = "section";
  header = "Work Experience";
  content = {
    nixos-foundation = {
      type = "itemlist";
      order = [
        "organization"
        "details"
      ];
      content = {
        organization = {
          type = "item";
          content = "The NixOS Foundation";
          format = {
            size = "large";
            bold = true;
          };
        };
        details = {
          type = "itemlist";
          order = [
            "position"
            "location"
            "dates"
            "nix-dev"
            "web-dev"
          ];
          content = {
            position = {
              type = "item";
              content = "Software Engineer";
              format = {
                bold = true;
              };
            };
            location = {
              type = "item";
              content = "Remote";
            };
            dates = {
              type = "item";
              content = "2020 - 2023";
              format = {
                italic = true;
              };
            };
            nix-dev = {
              type = "itemlist";
              content = {
                _role = {
                  type = "item";
                  content = "Nix Developer";
                };
                nix-dev = {
                  type = "itemlist";
                  content = {
                    responsibilities = {
                      type = "items";
                      format = {
                        italic = true;
                      };
                      content = [
                        "I make the Nix."
                        "I make the flakes."
                        "I make users cry."
                      ];
                    };
                  };
                };
              };
            };
            web-dev = {
              type = "itemlist";
              content = {
                _role = {
                  type = "item";
                  content = "Web Developer";
                };
                nix-dev = {
                  type = "itemlist";
                  content = {
                    responsibilities = {
                      type = "items";
                      content = [
                        "I make the Nix site."
                        "I use HTML and CSS only."
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
