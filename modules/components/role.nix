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
    rolePrefix = lib.mkOption {
      description = "A prefix to the role.";
      type = types.nullOr types.str;
      default = null;
    };
    roleSuffix = lib.mkOption {
      description = "A suffix to the role.";
      type = types.nullOr types.str;
      default = null;
    };
    role = lib.mkOption {
      description = "Your role.";
      type = types.str;
    };
    responsibilities = lib.mkOption {
      description = "Your responsibilities for this role.";
      type = types.listOf types.str;
    };
    roleSep = lib.mkOption {
      description = "The separator between `role` and `responsibilities`.";
      type = types.str;
      default = "\n";
      example = "\n";
    };
    respSep = lib.mkOption {
      description = "The separator between `responsibilities` elements.";
      type = types.str;
      default = "\n";
      example = "\n";
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
      lib.concatStringsSep
      cfg.roleSep
      [
        (
          (lib.optionalString (! builtins.isNull cfg.rolePrefix) (cfg.rolePrefix))
          + cfg.role
          + (lib.optionalString (! builtins.isNull cfg.roleSuffix) (cfg.roleSuffix))
        )
        (
          utils.concatStringsSepFiltered
          cfg.respSep
          ""
          cfg.responsibilities
        )
      ];
  };
}
