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
        ../sections/personal.nix
        ../sections/section.nix
      ]
    )
    (
      import
      ../components/latexEnvironment.nix
      "document"
    )
    ../components/standardStringOut.nix
  ];
  config = {
    _out = let
      wrapLatex = input:
        lib.concatStringsSep
        "\n"
        (
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
