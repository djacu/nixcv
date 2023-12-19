{
  config,
  lib,
  ...
}: let
  inherit (lib) types;
  cfg = config;
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
      location = {
        address = lib.mkOption {
          description = "Your street address.";
          type = types.str;
          default = "";
          defaultText = "123 Cherry Lane";
        };
        postalCode = lib.mkOption {
          description = "Your postal code.";
          type = types.str;
          default = "";
          defaultText = "12345";
        };
        city = lib.mkOption {
          description = "Your city.";
          type = types.str;
          default = "";
          defaultText = "San Francisco";
        };
        countryCode = lib.mkOption {
          description = "Your country code.";
          type = types.str;
          default = "";
          defaultText = "US";
        };
        region = lib.mkOption {
          description = "Your region/state.";
          type = types.str;
          default = "";
          defaultText = "California";
        };
      };
      profiles = lib.mkOption {
        description = "Your social media profiles.";
        type = types.listOf (types.submodule {
          options = {
            network = lib.mkOption {
              description = "The social media platform.";
              type = types.str;
            };
            username = lib.mkOption {
              description = "Your username on the platform.";
              type = types.str;
            };
            url = lib.mkOption {
              description = "The social media platform url.";
              type = types.str;
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
      type = types.listOf (types.submodule {
        options = {
          name = lib.mkOption {
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
            type = types.str;
            default = "";
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
            description = "A summary of your job.";
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
      });
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

  config = {
    all = {inherit (cfg) basics work;};
    plaintext = let
      basicInfo = (
        lib.concatStringsSep
        "\n"
        (
          lib.remove
          ""
          [
            cfg.basics.name
            cfg.basics.label
            cfg.basics.email
            cfg.basics.phone
            cfg.basics.url
          ]
        )
      );
      locationInfo = (
        lib.concatStringsSep
        ", "
        (
          lib.remove
          ""
          [
            cfg.basics.location.address
            cfg.basics.location.city
            cfg.basics.location.region
            cfg.basics.location.countryCode
            cfg.basics.location.postalCode
          ]
        )
      );
      profileInfo = (
        lib.concatStringsSep
        "\n"
        (builtins.map (x: x.url) cfg.basics.profiles)
      );
      workInfo = (
        lib.concatMapStringsSep
        "\n\n"
        (
          job: let
            rolesInfo = (
              lib.concatMapStringsSep
              "\n"
              (
                role:
                  lib.concatStringsSep
                  "\n"
                  (
                    lib.remove
                    ""
                    [
                      role.role
                      (
                        lib.concatStringsSep
                        "\n"
                        (
                          lib.remove
                          ""
                          role.responsibilities
                        )
                      )
                    ]
                  )
              )
              job.roles
            );
          in
            lib.concatStringsSep
            "\n"
            (
              lib.remove
              ""
              [
                job.name
                job.position
                job.location
                job.url
                # add conditionals if one or both dates are not present
                "${job.startDate} - ${job.endDate}"
                job.summary
                (
                  lib.concatStringsSep
                  "\n"
                  job.highlights
                )
                rolesInfo
              ]
            )
        )
        cfg.work
      );
    in
      lib.concatStringsSep
      "\n\n"
      [
        (
          lib.concatStringsSep
          "\n"
          [
            basicInfo
            locationInfo
            profileInfo
          ]
        )
        workInfo
      ];
  };
}
