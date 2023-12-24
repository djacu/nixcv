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
    street = lib.mkOption {
      description = "The street address including building/house/floor/unit/apartment numbers.";
      default = null;
      type = types.nullOr types.str;
    };
    district = lib.mkOption {
      description = "The district.";
      default = null;
      type = types.nullOr types.str;
    };
    suburb = lib.mkOption {
      description = "The suburb.";
      default = null;
      type = types.nullOr types.str;
    };
    city = lib.mkOption {
      description = "The city.";
      default = null;
      type = types.nullOr types.str;
    };
    town = lib.mkOption {
      description = "The town.";
      default = null;
      type = types.nullOr types.str;
    };
    village = lib.mkOption {
      description = "The village.";
      default = null;
      type = types.nullOr types.str;
    };
    state = lib.mkOption {
      description = "The state.";
      default = null;
      type = types.nullOr types.str;
    };
    province = lib.mkOption {
      description = "The province.";
      default = null;
      type = types.nullOr types.str;
    };
    region = lib.mkOption {
      description = "The region.";
      default = null;
      type = types.nullOr types.str;
    };
    country = lib.mkOption {
      description = "The country.";
      default = null;
      type = types.nullOr types.str;
    };
    postalCode = lib.mkOption {
      description = "The postal/zip code.";
      default = null;
      type = types.nullOr types.str;
    };
    sep = lib.mkOption {
      description = "The separator between sections of the address.";
      type = types.str;
      default = ", ";
      example = "\n";
    };
    format = lib.mkOption {
      description = "The elements of the address to incude in order.";
      type = types.listOf types.str;
      default = [
        "street"
        "city"
        "state"
        "country"
        "postalCode"
      ];
    };
    userStr = lib.mkOption {
      description = ''
        A user override of the address output.
      '';
      type = types.nullOr types.str;
      default = null;
      example = "Remote, USA";
    };
    _outPlaintext = lib.mkOption {
      description = "This modules output.";
      type = types.str;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext =
      if ! builtins.isNull cfg.userStr
      then cfg.userStr
      else
        (
          utils.concatStringsSepFiltered
          cfg.sep
          null
          (
            builtins.map
            (x: cfg.${x})
            cfg.format
          )
        );
  };
}
