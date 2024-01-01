{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  listInfo = {
    optionName = "socials";
    description = "A list of social media profiles.";
    subType = [../components/socials.nix];
  };
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["personal"];
      default = "personal";
      internal = true;
      description = "Type";
    };
    name = lib.mkOption {
      description = "Your full name.";
      type = types.nullOr types.str;
      default = null;
      example = "Johnathan Doe";
    };
    label = lib.mkOption {
      description = "Your job title or general field of expertise.";
      type = types.nullOr types.str;
      default = null;
      example = "Programmer";
    };
    email = lib.mkOption {
      description = "Your email.";
      type = types.nullOr types.str;
      default = null;
      example = "john@doe.com";
    };
    phone = lib.mkOption {
      description = "Your phone number.";
      type = types.nullOr types.str;
      default = null;
      example = "(123) 456-7890";
    };
    url = lib.mkOption {
      description = "Your website.";
      type = types.nullOr types.str;
      default = null;
      example = "https://john.doe.com";
    };
    location = lib.mkOption {
      description = "Your location information.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/address.nix
        ];
      });
      default = null;
    };
    profiles = lib.mkOption {
      description = "Your social media profiles.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          (import ../components/genericList.nix listInfo)
        ];
      });
      default = null;
    };

    order = lib.mkOption {
      description = "The order of the profile items.";
      type = types.listOf types.str;
      default = [
        "name"
        "label"
        "email"
        "phone"
        "url"
        "location"
        "profiles"
      ];
    };

    _outPlaintext = lib.mkOption {
      description = "This modules output.";
      type = types.str;
      readOnly = true;
    };
  };
  config = let
    cfgItems =
      builtins.removeAttrs
      cfg
      ["_module" "_outPlaintext"];
  in {
    _outPlaintext = (
      lib.concatStringsSep
      "\n"
      ( # get plaintext if its a submodule otherwise get the value
        (builtins.map)
        (x: x._outPlaintext or x)
        ( # remove the nulls
          builtins.filter
          (x: ! builtins.isNull x)
          ( # extract the options in order
            builtins.map
            (x: cfgItems.${x})
            cfg.order
          )
        )
      )
    );
  };
}
