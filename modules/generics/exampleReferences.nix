{
  type = "section";
  header = "References";
  content = {
    john-doe = {
      type = "itemlist";
      order = [
        "name"
        "details"
      ];
      content = {
        name = {
          type = "item";
          content = "John Doe";
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
              content = "Some Company";
              format = {
                bold = true;
              };
            };
            phone = {
              type = "item";
              content = "123.456.7890";
            };
          };
        };
      };
    };
    jane-doe = {
      type = "itemlist";
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
}
