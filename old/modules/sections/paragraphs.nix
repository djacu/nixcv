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

    _out.paragraphs = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out.paragraphs = {
      plaintext = (
        utils.concatStringsSepFiltered
        cfg.sep
        null
        (builtins.attrValues cfg.paragraphs)
      );
      latex =
        utils.concatStringsSepFiltered
        "\n"
        ""
        (
          lib.flatten
          [
            "\\begin{blockquote}"
            cfg._out.paragraphs.plaintext
            "\\end{blockquote}"
          ]
        );
    };
  };
}
