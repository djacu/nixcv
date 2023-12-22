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
      description = "The district/suburb/area.";
      default = null;
      type = types.nullOr types.str;
    };
    city = lib.mkOption {
      description = "The city/town/village.";
      default = null;
      type = types.nullOr types.str;
    };
    state = lib.mkOption {
      description = "The state/province/region.";
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
    _outPlaintext = lib.mkOption {
      description = "This modules output.";
      type = types.str;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext = (
      utils.concatCommaFiltered
      null
      [
        cfg.street
        cfg.district
        cfg.city
        cfg.state
        cfg.country
        cfg.postalCode
      ]
    );
  };
}
