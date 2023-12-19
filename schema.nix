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
    all = cfg.basics;
    plaintext = (
      lib.concatStringsSep
      "\n"
      [
        cfg.basics.name
        cfg.basics.label
        cfg.basics.email
        cfg.basics.phone
        cfg.basics.url
      ]
    );
  };
}
