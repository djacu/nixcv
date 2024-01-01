{lib, ...}: {
  nixcv = {
    basic = {
      sections = {
        personal = {
          content = {
            basic = {
              type = "personal";
              name = "John Doe";
              label = "Programmer";
              email = "john@doe.com";
              phone = "(123) 456-7890";
              url = "https://john.doe.com";
              location = {
                street = "123 Nunya Drive Unit 42";
                city = "Clinton";
                state = "MI";
                country = "USA";
                postalCode = "64735";
              };
              profiles = {
                socials = [
                  {
                    url = "https://github.com/jdoe";
                  }
                  {
                    url = "https://mastodon.com/@jdoe";
                  }
                ];
              };
            };
          };
        };
        objective = {
          header = "Objective";
          headerFunc = lib.toUpper;
          content = {
            "001" = {
              type = "paragraphs";
              paragraphs = {
                intro = "I want to do nix!";
              };
            };
            "002" = {
              type = "paragraphs";
              paragraphs = {
                more01 = "A lot of nix!";
                more02 = "So much of it!";
              };
              sep = "\n";
            };
          };
        };
        education = {
          header = "Education";
          headerFunc = lib.toUpper;
          content = {
            "77Bach" = {
              type = "education";
              organization = "South Hemet Institute of Technology";
              discipline = "Software Development";
              credential = "Bachelor of Science";
              dates = {
                start = {
                  year = 1977;
                  month = 7;
                  day = 17;
                };
                end = {
                  year = 1978;
                  month = 8;
                  day = 18;
                };
              };
            };
            "78Mast" = {
              type = "education";
              organization = "South Hemet Institute of Technology";
              discipline = "Software Development";
              credential = "Master of Science";
              dates = {
                start = {
                  year = 1978;
                  month = 7;
                  day = 18;
                };
              };
            };
          };
        };
        experience = {
          header = "Experience";
          headerFunc = lib.toUpper;
          content = {
            nixos-foundation = {
              type = "experience";
              organization = "The NixOS Foundation";
              position = "Software Engineer";
              location.userStr = "Remote";
              summary = "A did Nix stuff.";
              highlights = "Stabilized flakes.";
              roles = [
                {
                  role = "Nix Dev";
                  responsibilities = [
                    "Make new nix things."
                    "Fix old nix things."
                  ];
                }
              ];
            };
          };
        };
        volunteer = {
          header = "Volunteer";
          headerFunc = lib.toUpper;
          content = {
            cat-lounge = {
              type = "experience";
              organization = "The Cat Lounge";
              position = "Volunteer";
              location = {
                street = "123 Nunya Drive Unit 42";
                city = "Clinton";
                state = "MI";
                country = "USA";
                postalCode = "64735";
              };
              summary = "I pet the kitties.";
            };
          };
        };
        extra = {
          header = "Extra";
          headerFunc = lib.toUpper;
          content = {
            foss = {
              type = "namedlist";
              name = "FOSS";
              items = [
                "Contributor to nixpkgs."
                "On the NixOS foundation board."
              ];
            };
            personal = {
              type = "namedlist";
              name = "Personal";
              items = [
                "Run my own server."
              ];
            };
          };
        };
        skills = {
          header = "Skills";
          headerFunc = lib.toUpper;
          sep = "\n";
          content = {
            web-dev = {
              type = "skill";
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
            };
            nix-dev = {
              type = "skill";
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
            };
            random = {
              type = "skill";
              keywords = ["Random" "Things" "I" "Like"];
              keywordsSep = ".";
            };
          };
        };
        references = {
          header = "References";
          headerFunc = lib.toUpper;
          content = {
            john-doe = {
              type = "reference";
              name = "John Doe";
              organization = "The NixOS Foundation";
              phone = "123.456.7890";
              email = "johndoe@nixos.org";
            };
            jane-doe = {
              name = "Jane Doe";
              type = "reference";
              organization = "The NixOS Foundation";
              phone = "111.222.3333";
              email = "janedoe@nixos.org";
            };
          };
        };
      };
    };
  };
}
