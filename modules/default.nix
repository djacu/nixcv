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
    nixcv = lib.mkOption {
      description = "Your CV.";
      type = types.submodule {
        options = {
          startDate = lib.mkOption {
            description = "The start date.";
            type = types.submoduleWith {
              modules = [./date.nix];
            };
          };
          endDate = lib.mkOption {
            description = "The start date.";
            type = types.submoduleWith {
              modules = [./date.nix];
            };
          };
        };
      };
    };
  };
}
