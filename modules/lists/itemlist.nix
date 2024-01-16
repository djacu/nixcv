{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardListStringOut.nix
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
    (
      import
      ../components/latexEnvironment.nix
      "nolabel"
    )
  ];
  options = {
    type = lib.mkOption {
      type = types.enum ["itemlist"];
      default = "itemlist";
      description = "Type";
      internal = true;
    };
  };
  config = {
    _out = let
      wrapLatex = input: (
        lib.flatten
        [
          "\\begin{${cfg.latexEnvironment}}"
          (
            builtins.map
            (x: "  " + x)
            input
          )
          "\\end{${cfg.latexEnvironment}}"
        ]
      );
    in {
      plaintext = "";
      latex = wrapLatex (cfg.outOrdered "latex");
    };
  };
}
