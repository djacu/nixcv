{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      date = lib.mkOption {
        description = "A single date.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "separator" "order" "userStr" "monthLong" "monthShort" "monthLanguage"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./date.nix];};})
          );
        };
      };
      dates = lib.mkOption {
        description = "A date range.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["empty" "basic" "separator"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./dateRange.nix];
                  };
                }
            )
          );
        };
      };
      socials = lib.mkOption {
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./socials.nix];};})
          );
        };
      };
      address = lib.mkOption {
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "format" "separator"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./address.nix];};})
          );
        };
      };
      education = lib.mkOption {
        description = "An education entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["empty" "basic" "endDate"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./education.nix];
                  };
                }
            )
          );
        };
      };
      experience = lib.mkOption {
        description = "An experience entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["empty" "basic"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./experience.nix];
                  };
                }
            )
          );
        };
      };
      skill = lib.mkOption {
        description = "A skill entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "sep"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./skill.nix];
                  };
                }
            )
          );
        };
      };
      skills = lib.mkOption {
        description = "A skills entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "sep"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./skills.nix];
                  };
                }
            )
          );
        };
      };
      reference = lib.mkOption {
        description = "A reference entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./reference.nix];
                  };
                }
            )
          );
        };
      };
      references = lib.mkOption {
        description = "A references entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "sep"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./references.nix];
                  };
                }
            )
          );
        };
      };
      skillsSection = lib.mkOption {
        description = "A references entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "sep" "headerFunc"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./section.nix];
                  };
                }
            )
          );
        };
      };
    };
  };
  config = {
    nixcv = {
      date = {
        basic = {
          year = 2021;
          month = 11;
          day = 4;
        };
        separator = {
          year = 2021;
          month = 11;
          day = 4;
          sep = ".";
          order = "dmy";
        };
        order = {
          year = 2021;
          month = 11;
          day = 4;
          order = "dmy";
        };
        userStr = {
          userStr = "I can write anything!";
        };
        monthLong = {
          year = 2021;
          month = 11;
          day = 4;
          monthFormat = "long";
        };
        monthShort = {
          year = 2021;
          month = 11;
          day = 4;
          monthFormat = "short";
        };
        monthLanguage = {
          year = 2023;
          month = 12;
          day = 14;
          monthLanguage = "blah";
          monthFormat = "long";
          _months.blah = {
            short = {
              "1" = "xxx.";
              "2" = "xxx.";
              "3" = "xxx.";
              "4" = "xxx.";
              "5" = "xxx";
              "6" = "xxx.";
              "7" = "xxx.";
              "8" = "xxx.";
              "9" = "xxx.";
              "10" = "xxx.";
              "11" = "xxx.";
              "12" = "xxx.";
            };
            long = {
              "1" = "YYYJanuary";
              "2" = "YYYFebruary";
              "3" = "YYYMarch";
              "4" = "YYYApril";
              "5" = "YYYMay";
              "6" = "YYYJune";
              "7" = "YYYJuly";
              "8" = "YYYAugust";
              "9" = "YYYSeptember";
              "10" = "YYYOctober";
              "11" = "YYYNovember";
              "12" = "YYYDecember";
            };
          };
        };
      };
      dates = {
        empty = {};
        basic = {
          start = {
            year = 2021;
            month = 11;
            day = 4;
          };
          end = {
            year = 2022;
            month = 7;
            day = 16;
          };
        };
        separator = {
          start = {
            year = 2021;
            month = 11;
            day = 4;
          };
          end = {
            year = 2022;
            month = 7;
            day = 16;
          };
          sep = " to ";
        };
      };
      socials = {
        basic = {
          url = "https://djacu.dev/";
        };
      };
      address = {
        basic = {
          street = "123 Nunya Drive Unit 42";
          city = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
        };
        format = {
          street = "123 Nunya Drive Unit 42";
          town = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
          format = [
            "street"
            "town"
            "state"
            "country"
            "postalCode"
          ];
        };
        separator = {
          street = "123 Nunya Drive Unit 42";
          city = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
          sep = "\n";
        };
      };
      education = {
        empty = {};
        basic = {
          organization = "South Hemet Institute of Technology.";
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
        endDate = {
          organization = "South Hemet Institute of Technology.";
          discipline = "Software Development";
          credential = "Bachelor of Science";
          dates = {
            end = {
              year = 1978;
              month = 8;
              day = 18;
            };
          };
        };
      };
      experience = {
        empty = {};
        basic = {
          organization = "The NixOS Foundation";
          position = "Software Engineer";
          location.userStr = "Remote";
          url = "https://nixos.org/";
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
      skill = {
        basic = {
          label = "Web Development";
          keywords = ["HTML" "CSS" "JavaScript"];
        };
        sep = {
          label = "Web Development";
          keywords = ["HTML" "CSS" "JavaScript"];
          sep = " - ";
        };
      };
      skills = {
        basic = {
          skills = [
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
        sep = {
          skills = [
            {
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
              sep = " - ";
            }
            {
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
              sep = " - ";
            }
          ];
          sep = "; ";
        };
      };
      reference = {
        basic = {
          name = "John Doe";
          organization = "The NixOS Foundation";
          phone = "123.456.7890";
          email = "jdoe@nixos.org";
        };
      };
      references = {
        basic = {
          references = [
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
        sep = {
          references = [
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
          sep = "\n\n\n";
        };
      };
      skillsSection = {
        basic = {
          header = "Skills";
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
          _module.args = {modules = [./skill.nix];};
        };
        sep = {
          header = "Skills";
          content = [
            {
              label = "Web Development";
              keywords = ["HTML" "CSS" "JavaScript"];
              sep = " - ";
            }
            {
              label = "Nix Development";
              keywords = ["Nixpkgs" "NixOS" "Modules"];
              sep = " - ";
            }
          ];
          _module.args = {modules = [./skill.nix];};
          sep = "; ";
        };
        headerFunc = {
          header = "Skills";
          headerFunc = lib.toUpper;
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
          _module.args = {modules = [./skill.nix];};
        };
      };
    };
  };
}
