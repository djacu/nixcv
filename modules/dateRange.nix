{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    start = lib.mkOption {
      description = "The start date.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ./date.nix
        ];
      });
      default = null;
      example = "September 2000";
    };
    end = lib.mkOption {
      description = "The end date.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ./date.nix
        ];
      });
      default = null;
      example = "May 2004";
    };
    sep = lib.mkOption {
      description = "The separator between the year, month, and day.";
      type = types.str;
      default = " - ";
      example = " to ";
    };
    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext =
      lib.concatStrings
      [
        "${cfg.start._outPlaintext}"
        "${cfg.sep}"
        "${cfg.end._outPlaintext}"
      ];
  };
}
