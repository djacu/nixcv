{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ./utils.nix {inherit lib;};
in {
  options = {
    organization = lib.mkOption {
      description = "The name of the organization.";
      type = types.nullOr types.str;
      default = null;
      example = "South Hemet Institute of Technology";
    };
    url = lib.mkOption {
      description = "The organization website.";
      type = types.nullOr types.str;
      default = null;
      example = "https://www.southhemetit.edu/";
    };
    discipline = lib.mkOption {
      description = "Your area of study or major.";
      type = types.nullOr types.str;
      default = null;
      example = "Software Development";
    };
    credential = lib.mkOption {
      description = "The degree/certificate/etc you received.";
      type = types.nullOr types.str;
      default = null;
      example = "Bachelor";
    };
    dates = lib.mkOption {
      description = "The dates at this organization.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ./dateRange.nix
        ];
      });
      default = null;
      example = "September 2000";
    };
    score = lib.mkOption {
      description = "Your grade point average.";
      type = types.nullOr types.str;
      default = null;
      example = "4.0";
    };
    courses = lib.mkOption {
      description = "Courses you took.";
      type = types.nullOr (types.listOf types.str);
      default = null;
      example = ''
        [
          "DB1101 - Basic SQL"
        ]
      '';
    };
    _dates = lib.mkOption {
      description = "The date range";
      type = types.nullOr types.str;
      visible = false;
      readOnly = true;
    };
    _title = lib.mkOption {
      description = "The credential and discipline.";
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
    _title =
      if (builtins.isNull cfg.credential)
      then cfg.discipline
      else if (builtins.isNull cfg.discipline)
      then cfg.credential
      else if (builtins.isNull cfg.credential && builtins.isNull cfg.discipline)
      then null
      else cfg.credential + " in " + cfg.discipline;
    _dates =
      if (! builtins.isNull cfg.dates)
      then cfg.dates._outPlaintext
      else null;
    _outPlaintext =
      utils.concatNewlineFiltered
      null
      [
        cfg.organization
        cfg.url
        cfg._title
        cfg._dates
        # FIXME: add scores and courses
      ];
  };
}
