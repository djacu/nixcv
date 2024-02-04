{
  type = "personal";
  order = [
    "name"
    "socials"
  ];
  content = {
    name = {
      type = "text";
      content = "Jonathan Doe";
      format = {
        bold = true;
        size = "Huge";
      };
    };
    socials = {
      type = "itemlist";
      latexEnvironment = "minsep";
      order = [
        "location"
        "phone"
        "email"
        "linkedin"
        "github"
        "personalSite"
      ];
      content = {
        location = {
          type = "profile";
          content = "Nunya, USA";
          icon = "map-marker-alt";
        };
        phone = {
          type = "profile";
          content = "+0 123 456 7890";
          icon = "phone-alt";
        };
        email = {
          type = "profile";
          content = "jdoe@lavabit.com";
          icon = "inbox";
        };
        linkedin = {
          type = "profile";
          content = "linkedin.com/in/jdoe";
          icon = "linkedin";
        };
        github = {
          type = "profile";
          content = "github.com/jdoe";
          icon = "github";
        };
        personalSite = {
          type = "profile";
          content = "jdoe.io";
          icon = "user";
        };
      }; # content
    }; # socials
  }; # content
}
