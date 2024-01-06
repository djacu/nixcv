{lib, ...}: {
  nixcv = {
    allOptions = {
      order = [
        "personal"
        "objective"
        "education"
        "experience"
        "volunteer"
        "extra"
        "skills"
        "references"
      ];
      sections = {
        personal = {
          content = {
            basic = {
              type = "personal";
              name = "John Doe";
              label = "Programmer";
              email = "john@doe.com";
              phone = "(123) 456-7890";
              address = {
                street = "123 Nunya Drive Unit 42";
                city = "Clinton";
                state = "MI";
                country = "USA";
                postalCode = "64735";
              };
              profiles = {
                github = {
                  url = "https://github.com/jdoe";
                };
                mastodon = {
                  url = "https://mastodon.com/@jdoe";
                };
              };
            };
          };
        };
        objective = {
          header = "Objective";
          headerFunc = lib.toUpper;
          headerSep = "\n--------\n";
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
              sep = "\n\n";
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
              url = "https://www.southhemetit.edu/";
              discipline = "Software Development";
              credential = "Bachelor of Science";
              address = {
                city = "Hemet";
                state = "CA";
                country = "USA";
              };
              dateRange = {
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
              score = "3.33/4.00";
              courses = [
                "DB1101 - Basic SQL"
              ];
            };
            "78Mast" = {
              type = "education";
              organization = "South Hemet Institute of Technology";
              discipline = "Software Development";
              credential = "Master of Science";
              address = {
                city = "Hemet";
                state = "CA";
                country = "USA";
              };
              dateRange = {
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
          headerSep = "\n----------\n";
          sep = "\n---\n";
          content = {
            "1982-nixos-foundation" = {
              type = "experience";
              organization = "The NixOS Foundation";
              position = "Software Engineer";
              address.userStr = "Remote";
              url = "https://nixos.org/";
              dateRange = {
                start = {
                  year = 1982;
                };
                end = {
                  userStr = "Present";
                };
                sep = " to ";
              };
              summary = "A did Nix stuff.";
              highlights = "Stabilized flakes.";
              roles = {
                nix-dev = {
                  role = "Nix Dev";
                  responsibilities = [
                    "Make new nix things."
                    "Fix old nix things."
                  ];
                };
                marketing = {
                  role = "Marketing";
                  responsibilities = [
                    "Look at me."
                    "I make the tweets now."
                  ];
                };
              };
            };
            "1980-guix-foundation" = {
              type = "experience";
              organization = "The Guix Foundation";
              position = "Software Engineer";
              dateRange = {
                start = {
                  year = 1980;
                };
                end = {
                  year = 1982;
                };
              };
              summary = "A did Guix stuff.";
              roles = {
                guix-dev = {
                  role = "Guix Dev";
                  responsibilities = [
                    "Make new guix things."
                    "Fix old guix things."
                  ];
                };
              };
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
              address = {
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
          content = {
            skills = {
              type = "skills";
              skills = {
                web-dev = {
                  label = "Web Development";
                  labelSep = " - ";
                  keywords = ["HTML" "CSS" "JavaScript"];
                };
                nix-dev = {
                  label = "Nix Development";
                  level = "Master";
                  keywords = ["Nixpkgs" "NixOS" "Modules"];
                };
                random = {
                  keywords = ["Random" "Things" "I" "Like"];
                  keywordsSep = ".";
                };
              };
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
              type = "reference";
              name = "Jane Doe";
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
