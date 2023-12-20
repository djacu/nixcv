{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  date = import ./date.nix;
in {
  options = {
    nixcv = {
      startDate = lib.mkOption {
        description = "The start date.";
        type = types.submodule date;
      };
      endDate = lib.mkOption {
        description = "The start date.";
        type = types.submodule date;
      };
    };
  };
}
