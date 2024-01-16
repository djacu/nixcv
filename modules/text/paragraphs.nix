{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/format.nix
    ../components/orderedContent.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["paragraphs"];
      default = "paragraphs";
      description = "Type";
      internal = true;
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
  config = let
    wrapLatex = input: (
      lib.flatten
      [
        "\\begin{blockquote}"
        (
          builtins.map
          (x: "  " + x)
          input
        )
        "\\end{blockquote}"
      ]
    );
  in {
    _out = {
      plaintext = "";
      latex = wrapLatex cfg.contentsOrdered;
    };
  };
}
