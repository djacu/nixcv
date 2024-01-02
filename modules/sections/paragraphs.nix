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
      type = lib.types.enum ["paragraphs"];
      default = "paragraphs";
      internal = true;
      description = "Type";
    };
    paragraphs = lib.mkOption {
      description = "Paragraphs describing whatever you want.";
      type = types.nullOr (types.attrsOf types.str);
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
    _outLatex = lib.mkOption {
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
      (builtins.attrValues cfg.paragraphs)
    );
    _outLatex =
      utils.concatStringsSepFiltered
      "\n"
      ""
      (
        lib.flatten
        [
          "\\begin{blockquote}"
          cfg._outPlaintext
          "\\end{blockquote}"
        ]
      );
  };
}
