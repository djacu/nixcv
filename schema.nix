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
        type = types.str;
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
          dateInfo = (
            if (job.endDate == "" || job.startDate == "")
            then ""
            else job.startDate + " - " + job.endDate
          );
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
            job.url
            dateInfo
            job.summary
            (
              concatNewlineFiltered
              job.highlights
            )
            rolesInfo
          ]
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
      workInfo = parseWorkConfig cfg.work;
      volunteerInfo = parseWorkConfig cfg.volunteer;
    in
      concatStringsSepFiltered
      "\n\n"
      [
        basicInfo
        workInfo
        volunteerInfo
      ];
  };
}
