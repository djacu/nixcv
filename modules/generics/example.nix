{...}: {
  type = "section";
  header = "Work Experience";
  content = {
    nixos-foundation = {
      type = "itemlist";
      order = [
        "organization"
        "position"
        "nix-dev"
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
        nix-dev = {
          type = "itemlist";
          content = {
            _role = {
              type = "item";
              content = "Nix Software Developer";
            };
            nix-dev = {
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
            };
          };
        };
      };
    };
  };
}
