{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["experience"];
      default = "experience";
      internal = true;
      description = "Type";
    };
    organization = lib.mkOption {
      description = "The name of the organization.";
      type = types.nullOr types.str;
      default = null;
      example = "The NixOS Foundation";
    };
    position = lib.mkOption {
      description = "Your position/title.";
      type = types.nullOr types.str;
      default = null;
      example = "Software Engineer";
    };
    location = lib.mkOption {
      description = "The organization location or place where you worked.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/address.nix
        ];
      });
      default = null;
    };
    url = lib.mkOption {
      description = "The organization website.";
      type = types.nullOr types.str;
      default = null;
      example = "https://nixos.org/";
    };
    dates = lib.mkOption {
      description = "The dates at this organization.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/dateRange.nix
        ];
      });
      default = null;
      example = "September 2000";
    };
    summary = lib.mkOption {
      description = "A summary of your work.";
      type = types.nullOr types.str;
      default = null;
    };
    highlights = lib.mkOption {
      description = "Highlights of your work.";
      type = types.nullOr types.str;
      default = null;
    };
    roles = lib.mkOption {
      description = "A collection of your roles and responsibilities.";
      type = types.nullOr (types.listOf (types.submodule {
        options = {
          role = lib.mkOption {
            description = "Your role.";
            type = types.str;
          };
          responsibilities = lib.mkOption {
            description = "Your responsibilities for this role.";
            type = types.listOf types.str;
          };
        };
      }));
      default = null;
    };
    order = lib.mkOption {
      description = "The order of the experience items.";
      type = types.listOf types.str;
      default = [
        "organization"
        "position"
        "location"
        "url"
        "dates"
        "summary"
        "highlights"
        "_roles"
      ];
    };

    _roles = lib.mkOption {
      description = "The location.";
      type = types.nullOr types.str;
      visible = false;
      readOnly = true;
    };

    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = let
    cfgItems =
      builtins.removeAttrs
      cfg
      [
        "_module"
        "_outLatex"
        "_outPlaintext"
        "order"
        "type"
        "role" # FIXME: remove after making a roles module
      ];
    plaintextOrdered =
      if builtins.isNull cfg.order
      then builtins.attrValues cfgItems
      else
        (
          builtins.map
          (elem: cfgItems.${elem})
          cfg.order
        );
  in {
    _roles =
      if (builtins.isNull cfg.roles)
      then null
      else
        (
          lib.concatMapStringsSep
          "\n"
          (
            role:
              utils.concatNewlineFiltered
              null
              [
                ("Role in " + role.role + ".")
                (
                  utils.concatNewlineFiltered
                  null
                  role.responsibilities
                )
              ]
          )
          cfg.roles
        );

    _outPlaintext = (
      lib.concatStringsSep
      "\n"
      ( # get plaintext if its a submodule otherwise get the value
        (builtins.map)
        (x: x._outPlaintext or x)
        ( # remove the nulls
          builtins.filter
          (x: ! builtins.isNull x)
          plaintextOrdered
        )
      )
    );
  };
}
