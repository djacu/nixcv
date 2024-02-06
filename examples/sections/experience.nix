{
  type = "section";
  header = "Experience";
  order = [
    "nixos-foundation"
  ];
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
            bold = true;
            size = "large";
          };
        }; # organization
        details = {
          type = "itemlist";
          order = [
            "title"
            "location"
            "dates"
            "jupyenv"
            "nixgroup"
          ];
          content = {
            title = {
              type = "item";
              content = "Software Engineer";
              format = {
                bold = true;
              };
            }; # title
            location = {
              type = "item";
              content = "USA";
            }; # location
            dates = {
              type = "item";
              content = "June 1999 - Present";
              format = {
                italic = true;
              };
            }; # dates
            jupyenv = {
              type = "itemlist";
              content = {
                _role = {
                  type = "item";
                  content = "Nix Developer";
                };
                responsibilities = {
                  type = "itemlist";
                  content = {
                    responsibilities = {
                      type = "items";
                      content = [
                        "I make the Nix."
                        "I make the flakes."
                        "I make users cry."
                      ];
                    };
                  };
                }; # responsibilities
              }; # content
            }; # jupyenv
            nixgroup = {
              type = "itemlist";
              content = {
                _role = {
                  type = "item";
                  content = "Web Developer";
                };
                responsibilities = {
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
                }; # responsibilities
              }; # content
            }; # nixgroup
          }; # content
        }; # details
      }; # content
    };
  };
}
