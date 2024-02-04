{
  type = "section";
  header = "Education";
  order = [
    "shit-ms-bs"
    "shit-bs-bs"
  ];
  content = {
    shit-ms-bs = {
      type = "itemlist";
      order = [
        "organization"
        "details"
      ];
      content = {
        organization = {
          type = "item";
          content = "South Hemet Institute of Technology";
          format = {
            bold = true;
            size = "large";
          };
        }; # organization
        details = {
          type = "itemlist";
          order = [
            "degree"
            "location"
            "dates"
          ];
          content = {
            degree = {
              type = "item";
              content = "Master of Science in Bovine Scatology";
              format = {
                bold = true;
              };
            }; # degree
            location = {
              type = "item";
              content = "Hemet, California, USA";
            }; # location
            dates = {
              type = "item";
              content = "August 1999 -- May 2001";
              format = {
                italic = true;
              };
            }; # dates
          }; # content
        }; # details
      }; # content
    }; # shit-ms-bs

    shit-bs-bs = {
      type = "itemlist";
      order = [
        "organization"
        "details"
      ];
      content = {
        organization = {
          type = "item";
          content = "South Hemet Institute of Technology";
          format = {
            bold = true;
            size = "large";
          };
        }; # organization
        details = {
          type = "itemlist";
          order = [
            "degree"
            "location"
            "dates"
          ];
          content = {
            degree = {
              type = "item";
              content = "Bachelor of Science in Bovine Scatology";
              format = {
                bold = true;
              };
            }; # degree
            location = {
              type = "item";
              content = "Hemet, California, USA";
            }; # location
            dates = {
              type = "item";
              content = "August 1995 -- May 1999";
              format = {
                italic = true;
              };
            }; # dates
          }; # content
        }; # details
      }; # content
    }; # shit-bs-bs
  }; # content
}
