{
  config,
  lib,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  locationOptions = {
    options = {
      fullAddress = lib.mkOption {
        description = "The full address.";
        type = types.str;
        default = "";
        defaultText = "123 Cherry Lane";
      };
      address = lib.mkOption {
        description = "The street address.";
        type = types.str;
        default = "";
        defaultText = "123 Cherry Lane";
      };
      postalCode = lib.mkOption {
        description = "The postal code.";
        type = types.str;
        default = "";
        defaultText = "12345";
      };
      city = lib.mkOption {
        description = "The city.";
        type = types.str;
        default = "";
        defaultText = "San Francisco";
      };
      countryCode = lib.mkOption {
        description = "The country code.";
        type = types.str;
        default = "";
        defaultText = "US";
      };
      region = lib.mkOption {
        description = "The region/state.";
        type = types.str;
        default = "";
        defaultText = "California";
      };
    };
  };
  workOptions = {
    options = {
      name = lib.mkOption {
        description = "The company name (alternative to organization).";
        type = types.str;
        default = "";
      };
      organization = lib.mkOption {
        description = "The company name.";
        type = types.str;
        default = "";
      };
      position = lib.mkOption {
        description = "Your position.";
        type = types.str;
        default = "";
      };
      location = lib.mkOption {
        description = "The location where you worked.";
        type = types.submodule locationOptions;
        default = {};
      };
      url = lib.mkOption {
        description = "The company website.";
        type = types.str;
        default = "";
      };
      startDate = lib.mkOption {
        description = "Your start date.";
        type = types.str;
        default = "";
      };
      endDate = lib.mkOption {
        description = "Your end date.";
        type = types.str;
        default = "";
      };
      summary = lib.mkOption {
        description = "A summary of your work.";
        type = types.either types.str types.lines;
        default = "";
      };
      highlights = lib.mkOption {
        description = "Highlights of your work.";
        type = types.listOf types.str;
        default = [];
      };
      roles = lib.mkOption {
        description = "A collection of your roles and responsibilities.";
        type = types.listOf (types.submodule {
          options = {
            role = lib.mkOption {
              description = "Your role.";
              type = types.str;
              default = "";
            };
            responsibilities = lib.mkOption {
              description = "Your responsibilities for this role.";
              type = types.listOf types.str;
              default = [];
            };
          };
        });
        default = [];
      };
    };
  };
in {
  options = {
    basics = {
      name = lib.mkOption {
        description = "Your full name.";
        type = types.str;
        default = "";
        defaultText = "John Doe";
      };
      label = lib.mkOption {
        description = "Your job title.";
        type = types.str;
        default = "";
        defaultText = "Programmer";
      };
      email = lib.mkOption {
        description = "Your email.";
        type = types.str;
        default = "";
        defaultText = "john@doe.com";
      };
      phone = lib.mkOption {
        description = "Your phone number.";
        type = types.str;
        default = "";
        defaultText = "(123) 456-7890";
      };
      url = lib.mkOption {
        description = "Your website.";
        type = types.str;
        default = "";
        defaultText = "https://john.doe.com";
      };
      summary = lib.mkOption {
        description = "A summary of yourself.";
        type = types.str;
        default = "";
        defaultText = "John doe is a ...";
      };
      location = lib.mkOption {
        description = "Your location information.";
        type = types.submodule locationOptions;
        default = {};
      };
      profiles = lib.mkOption {
        description = "Your social media profiles.";
        type = types.listOf (types.submodule {
          options = {
            network = lib.mkOption {
              description = "The social media platform.";
              type = types.str;
              default = "";
            };
            username = lib.mkOption {
              description = "Your username on the platform.";
              type = types.str;
              default = "";
            };
            url = lib.mkOption {
              description = "The social media platform url.";
              type = types.str;
              default = "";
            };
          };
        });
        default = [];
        defaultText = ''
          [
            {
              network = "LinkedIn";
              username = "jdoe";
              url = "https://www.linkedin.com/in/jdoe/";
            }
          ]
        '';
      };
    };
    work = lib.mkOption {
      description = "Your work experience.";
      type = types.listOf (types.submodule workOptions);
      default = [];
    };
    volunteer = lib.mkOption {
      description = "Your volunteer experience.";
      type = types.listOf (types.submodule workOptions);
      default = [];
    };
    education = lib.mkOption {
      description = "Your education history.";
      type = types.listOf (types.submodule {
        options = {
          institution = lib.mkOption {
            description = "The name of the institution of learning.";
            type = types.str;
            default = "";
            defaultText = "South Hemet Institute of Technology";
          };
          url = lib.mkOption {
            description = "The institution website.";
            type = types.str;
            default = "";
            defaultText = "https://www.southhemetit.edu/";
          };
          area = lib.mkOption {
            description = "Your area of study or major.";
            type = types.str;
            default = "";
            defaultText = "Software Development";
          };
          studyType = lib.mkOption {
            description = "The degree you received.";
            type = types.str;
            default = "";
            defaultText = "Bachelor";
          };
          startDate = lib.mkOption {
            description = "The date you started.";
            type = types.str;
            default = "";
            defaultText = "September 2000";
          };
          endDate = lib.mkOption {
            description = "The date you finished.";
            type = types.str;
            default = "";
            defaultText = "May 2004";
          };
          score = lib.mkOption {
            description = "Your grade point average.";
            type = types.str;
            default = "";
            defaultText = "4.0";
          };
          courses = lib.mkOption {
            description = "Courses you took.";
            type = types.listOf types.str;
            default = [];
            defaultText = ''
              [
                "DB1101 - Basic SQL"
              ]
            '';
          };
        };
      });
      default = {};
    };
    skills = lib.mkOption {
      description = "Your skills.";
      type = types.listOf (types.submodule {
        options = {
          name = lib.mkOption {
            description = "The skill category.";
            type = types.str;
            default = "";
            defaultText = "Web Development";
          };
          level = lib.mkOption {
            description = "The skill category fluency.";
            type = types.str;
            default = "";
            defaultText = "Master";
          };
          keywords = lib.mkOption {
            description = "The skills for this category.";
            type = types.listOf types.str;
            default = "";
            defaultText = ''
              [
                "HTML"
                "CSS"
                "JavaScript"
              ]
            '';
          };
        };
      });
    };
  };

  options = {
    all = lib.mkOption {
      type = types.raw;
    };
    plaintext = lib.mkOption {
      type = types.str;
    };
  };

  config = let
    concatStringsSepFiltered = separator: list:
      lib.concatStringsSep
      separator
      (
        lib.remove
        ""
        list
      );
    concatNewlineFiltered = concatStringsSepFiltered "\n";
    concatCommaFiltered = concatStringsSepFiltered ", ";
    parseLocation = location:
      if (location.fullAddress != "")
      then location.fullAddress
      else
        concatCommaFiltered
        [
          location.address
          location.city
          location.region
          location.countryCode
          location.postalCode
        ];
    parseDates = attr: (
      if (attr.endDate == "" || attr.startDate == "")
      then ""
      else attr.startDate + " - " + attr.endDate
    );
    parseWorkConfig =
      lib.concatMapStringsSep
      "\n\n"
      (
        job: let
          rolesInfo = (
            lib.concatMapStringsSep
            "\n"
            (
              role:
                concatNewlineFiltered
                [
                  role.role
                  (
                    concatNewlineFiltered
                    role.responsibilities
                  )
                ]
            )
            job.roles
          );
          dateInfo = parseDates job;
        in
          concatNewlineFiltered
          [
            (
              if job.organization != ""
              then job.organization
              else job.name
            )
            job.position
            (parseLocation job.location)
            #job.url
            dateInfo
            job.summary
            (
              concatNewlineFiltered
              job.highlights
            )
            rolesInfo
          ]
      );
    parseEducationConfig =
      lib.concatMapStringsSep
      "\n\n"
      (
        edu: let
          studyInfo =
            edu.studyType
            + (
              if (edu.area == "")
              then ""
              else " in " + edu.area
            );
          scoreInfo = (
            if (edu.score == "")
            then ""
            else "Score: " + edu.score
          );
          coursesInfo = (
            if (builtins.length edu.courses == 0)
            then ""
            else "Courses: " + (concatCommaFiltered edu.courses)
          );
        in
          concatNewlineFiltered
          [
            edu.institution
            #edu.url
            studyInfo
            (parseDates edu)
            #scoreInfo
            #coursesInfo
          ]
      );
    parseSkills =
      lib.concatMapStringsSep
      "\n"
      (
        skill: skill.name + ": " + concatCommaFiltered skill.keywords
      );
  in {
    all = {inherit (cfg) basics work;};
    plaintext = let
      basicInfo = let
        personalInfo = (
          concatNewlineFiltered
          [
            cfg.basics.name
            cfg.basics.label
            cfg.basics.email
            cfg.basics.phone
            cfg.basics.url
          ]
        );
        locationInfo = parseLocation cfg.basics.location;
        profileInfo = (
          concatNewlineFiltered
          (builtins.map (x: x.url) cfg.basics.profiles)
        );
      in
        concatNewlineFiltered
        [
          personalInfo
          locationInfo
          profileInfo
        ];
      objectiveInfo = "OBJECTIVE\n" + (builtins.replaceStrings ["\n"] [" "] cfg.basics.summary);
      educationInfo = "EDUCATION\n" + parseEducationConfig cfg.education;
      workInfo = "EXPERIENCE\n" + parseWorkConfig cfg.work;
      volunteerInfo = "VOLUNTEER\n" + parseWorkConfig cfg.volunteer;
      skillsInfo = "SKILLS\n" + parseSkills cfg.skills;
    in
      concatStringsSepFiltered
      "\n\n"
      [
        basicInfo
        objectiveInfo
        educationInfo
        workInfo
        volunteerInfo
        skillsInfo
      ];
  };
}
