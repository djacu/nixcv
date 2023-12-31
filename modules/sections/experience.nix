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
    _dates = lib.mkOption {
      description = "The date range.";
      type = types.nullOr types.str;
      visible = false;
      readOnly = true;
    };
    _location = lib.mkOption {
      description = "The location.";
      type = types.nullOr types.str;
      visible = false;
      readOnly = true;
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
  config = {
    _dates =
      if (! builtins.isNull cfg.dates)
      then cfg.dates._outPlaintext
      else null;
    _location =
      if (! builtins.isNull cfg.location)
      then cfg.location._outPlaintext
      else null;
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

    _outPlaintext =
      utils.concatNewlineFiltered
      null
      [
        cfg.organization
        cfg.position
        cfg._location
        cfg.url
        cfg._dates
        cfg.summary
        cfg.highlights
        cfg._roles
      ];
  };
}
