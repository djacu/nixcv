{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    (
      import
      ../components/orderedTaggedContent.nix
      [
        ../lists/itemlist.nix
        ../text/paragraphs.nix
        ../skills/skills.nix
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

    _out = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.listOf types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };
  config = {
    _out = let
      wrapLatex = input: (
        lib.flatten
        [
          "" # white space helps with reading the latex output
          "\\section{${cfg.header}}"
          (
            builtins.map
            (x: "  " + x)
            input
          )
        ]
      );
    in {
      plaintext = "";
      latex = wrapLatex (cfg.outOrdered "latex");
    };
  };
}
