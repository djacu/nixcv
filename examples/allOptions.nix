{lib, ...}: {
  nixcv = {
    allOptions = {
      personal = {
        content = {
          basic = {
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
        headerSep = "\n--------\n";
        content = {
          "001" = {
            sections = [
              "I want to do nix!"
            ];
          };
          "002" = {
            sections = [
              "A lot of nix!"
              "So much of it!"
            ];
            sep = "\n\n";
          };
        };
      };
      education = {
        header = "Education";
        headerFunc = lib.toUpper;
        content = {
          "77Bach" = {
            organization = "South Hemet Institute of Technology";
            url = "https://www.southhemetit.edu/";
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
            score = "3.33/4.00";
            courses = [
              "DB1101 - Basic SQL"
            ];
          };
          "78Mast" = {
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
        headerSep = "\n----------\n";
        sep = "\n---\n";
        content = {
          "1982-nixos-foundation" = {
            organization = "The NixOS Foundation";
            position = "Software Engineer";
            location.userStr = "Remote";
            url = "https://nixos.org/";
            dates = {
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
            roles = [
              {
                role = "Nix Dev";
                responsibilities = [
                  "Make new nix things."
                  "Fix old nix things."
                ];
              }
              {
                role = "Marketing";
                responsibilities = [
                  "Look at me."
                  "I make the tweets now."
                ];
              }
            ];
          };
          "1980-guix-foundation" = {
            organization = "The Guix Foundation";
            position = "Software Engineer";
            dates = {
              start = {
                year = 1980;
              };
              end = {
                year = 1982;
              };
            };
            summary = "A did Guix stuff.";
            roles = [
              {
                role = "Guix Dev";
                responsibilities = [
                  "Make new guix things."
                  "Fix old guix things."
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
      skills = {
        header = "Skills";
        headerFunc = lib.toUpper;
        sep = "\n";
        content = {
          web-dev = {
            label = "Web Development";
            sep = " - ";
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
      references = {
        header = "References";
        headerFunc = lib.toUpper;
        content = {
          john-doe = {
            name = "John Doe";
            organization = "The NixOS Foundation";
            phone = "123.456.7890";
            email = "johndoe@nixos.org";
          };
          jane-doe = {
            name = "Jane Doe";
            organization = "The NixOS Foundation";
            phone = "111.222.3333";
            email = "janedoe@nixos.org";
          };
        };
      };
    };
  };
}
