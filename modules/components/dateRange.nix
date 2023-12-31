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
    _outPlaintext = let
      start =
        if (! builtins.isNull cfg.start)
        then cfg.start._outPlaintext
        else null;
      end =
        if (! builtins.isNull cfg.end)
        then cfg.end._outPlaintext
        else null;
      sep =
        if (builtins.isNull start || builtins.isNull end)
        then null
        else cfg.sep;
    in (
      utils.concatStringsSepFiltered
      ""
      null
      [
        start
        sep
        end
      ]
    );
  };
}
