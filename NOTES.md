# Notes

## Thoughts for next version

- I may have severly overcomplicated the modules.
  I was given a module hammer and everything looked like an option nail.
  I think I can reduce it to a few simple times with formatting fields.
  These thoughts are primarily for the LaTeX output.
  The plaintext output would handle similarly or even more easily.
  - Everything under the section content could possibly be distilled to a few types with exceptions.
    1. Paragraph text
    1. List items
  - The exceptions being
    1. The personal section because of profile items and icons
    1. The skills section because of the use of minipage and columns in LaTeX
    1. Also indenting (e.g. around the personal title area) would have to be handled better
- New schema
  - All submodules would have to be tagged so then can recurse easily.
  - Most/all types would be `attrsOf` or `submoduleWith` for easier overrides.
    Lists are just a pain to deal with when merging.
  - There needs to be a format option that will handle latex formatting.
    Some attrsOf with fields like `bold`, `italic`, `size`, etc.
- Things to check/think about
  - Can I override the labels for `newlist`/`setlist` commands?
  - Do I keep things like `date` and `address` modules or just revert to string types?
  - Could we handle `attrsOf` and `listOf` but just not worry about order for lists?
    And merging be damned?
  - Can I get away with `content = <string>` without making content a attrset and having a `type = "text"` field?
    Would drastically simplify things.
  - Do I even need types!? Attrs are nested lists! Just need an order?
  - Can I use override section formatting? Look at `\titleformat`.

Example:
```nix
{
  sections = {
    work-experience = {
      type = "section"; # Do I need this?
      header = "Experience";
      format = {
        bold = true;
        size = "LARGE";
      };
      order = [
        ...
      ];
      content = {
        nixos-foundation = {
          type = "itemlist";
          order = [
            "organization"
            "position"
            "address"
            "dates"
            "summary"
            "roles"
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
            position = {
              type = "item";
              content = "Software Engineer";
              format = {
                bold = true;
              };
            };
            # They shouldn't be full addresses so single line should be fine
            # At most City, State, Country...
            address = {
              type = "item";
              content = "USA";
            };
            dates = {
              type = "item";
              content = "2022 -- Present";
              format = {
                italic = true;
              };
            };
            summary = {
              type = "items"; # plural means multiple?
              content = {
                "001" = "I wrote a bunch of C!";
                "002" = "I wrote a bunch of Nix!";
                "003" = "I stabilized flakes!!!";
              };
            };
            roles = {
              type = "itemlist";
              content = {
                nix-dev = {
                  # sneaky use of "_" so _role appears before responsibilities
                  # if that is correct...
                  _role = {
                    type = "item";
                    content = "Nix Software Developer";
                  };
                  responsibilities  = {
                    type = "items";
                    "001" = "I fixed old stuff";
                    "002" = "I made new stuff";
                  };
                };
              };
            }; # roles
          }; # content
        }; # nixos-foundation
      }; # content
    }; # work-experience
  };
}
```
