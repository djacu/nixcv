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
    type = lib.mkOption {
      type = lib.types.enum ["objective"];
      default = "objective";
      internal = true;
      description = "Type";
    };
    sections = lib.mkOption {
      description = "Paragraphs describing your objective.";
      type = types.nullOr (types.listOf types.str);
      default = null;
      example = ''
        [
          "I want to do nix!."
        ]
      '';
    };
    sep = lib.mkOption {
      description = "The separator between sections.";
      type = types.str;
      default = "\n\n";
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
      cfg.sections
    );
  };
}
