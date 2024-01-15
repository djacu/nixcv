{
  type = "section";
  header = "References";
  content = {
    john-doe = {
      type = "itemlist";
      order = [
        "name"
        "organization"
        "phone"
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
    jane-doe = {
      type = "itemlist";
      order = [
        "name"
        "organization"
        "phone"
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
}
