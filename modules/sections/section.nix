{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  stringsLib = import ../../lib/strings.nix {inherit lib;};
in {
  imports = [
    ../components/standardListStringOut.nix
    ../components/latexWrapper.nix
    (
      import
      ../components/orderedTaggedContent.nix
      [
        ../lists/itemlist.nix
        ../text/paragraphs.nix
        ../skills/skills.nix
        ../biblatex/bibliography.nix
      ]
    )
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["section"];
      default = "section";
      description = "Type";
      internal = true;
    };
    header = lib.mkOption {
      description = "The section header.";
      type = types.nullOr types.str;
      default = null;
      example = "Experience";
    };
  };
  config = {
    latexWrapper = {
      prefix = [
        "" # white space helps with reading the latex output
        "\\section{${stringsLib.escapeLatex cfg.header}}"
      ];
      suffix = [];
      content = cfg.outOrdered "latex";
      predicate = x: "  " + x;
    };
    _out = {
      plaintext = "";
      latex = cfg.latexWrapper.output;
    };
  };
}
