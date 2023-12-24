{lib, ...}: {
  nixcv = {
    education = {
      header = "Education";
      headerFunc = lib.toUpper;
      content = [
        {
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
        }
        {
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
        }
      ];
    };
    experience = {
      header = "Experience";
      headerFunc = lib.toUpper;
      content = [
        {
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
        }
      ];
    };
    volunteer = {
      header = "Volunteer";
      headerFunc = lib.toUpper;
      content = [
        {
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
        }
      ];
    };
    skills = {
      header = "Skills";
      headerFunc = lib.toUpper;
      sep = "\n";
      content = [
        {
          label = "Web Development";
          keywords = ["HTML" "CSS" "JavaScript"];
        }
        {
          label = "Nix Development";
          keywords = ["Nixpkgs" "NixOS" "Modules"];
        }
      ];
    };
    references = {
      header = "References";
      headerFunc = lib.toUpper;
      content = [
        {
          name = "John Doe";
          organization = "The NixOS Foundation";
          phone = "123.456.7890";
          email = "johndoe@nixos.org";
        }
        {
          name = "Jane Doe";
          organization = "The NixOS Foundation";
          phone = "111.222.3333";
          email = "janedoe@nixos.org";
        }
      ];
    };
  };
}
