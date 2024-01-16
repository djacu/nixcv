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
  ];
  options = {
    _out = {
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
    _out = let
      wrapLatex = input:
        lib.concatStringsSep
        "\n"
        (
          lib.flatten
          [
            "\\begin{document}"
            (
              builtins.map
              (x: "  " + x)
              input
            )
            "\\end{document}"
          ]
        );
    in {
      plaintext = "";
      latex = wrapLatex (cfg.outOrdered "latex");
    };
  };
}
