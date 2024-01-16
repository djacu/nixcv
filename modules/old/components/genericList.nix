listInfo: {
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    ${listInfo.optionName} = lib.mkOption {
      inherit (listInfo) description;
      type = types.listOf (types.submoduleWith {
        modules = listInfo.subType;
      });
    };
    sep = lib.mkOption {
      description = "The separator list elements.";
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
    _outPlaintext = (
      utils.concatStringsSepFiltered
      cfg.sep
      null
      (
        builtins.map
        (x: x._outPlaintext)
        cfg.${listInfo.optionName}
      )
    );
  };
}
