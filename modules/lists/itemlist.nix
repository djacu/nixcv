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
        ./itemlist.nix
        ./item.nix
        ./items.nix
        ./profile.nix
      ]
    )
  ];
  options = {
    type = lib.mkOption {
      type = types.enum ["itemlist"];
      default = "itemlist";
      description = "Type";
      internal = true;
    };
    listname = lib.mkOption {
      type = types.str;
      default = "nolabel";
      description = "The LaTeX list environment name.";
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
          "\\begin{${cfg.listname}}"
          (
            builtins.map
            (x: "  " + x)
            input
          )
          "\\end{${cfg.listname}}"
        ]
      );
    in {
      plaintext = "";
      latex = wrapLatex (cfg.outOrdered "latex");
    };
  };
}
