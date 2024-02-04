{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardStringOut.nix
    ../components/latexWrapper.nix
    ../biblatex/bibresources.nix
    ../templates/default.nix
    (
      import
      ../components/taggedContent.nix
      {
        submodules = [
          ../sections/personal.nix
          ../sections/section.nix
        ];
      }
    )
    (
      import
      ../components/latexEnvironment.nix
      "document"
    )
  ];
  config = {
    latexWrapper = {
      prefix = [
        "\\input{cv}"
        ""
        "\\begin{${cfg.latexEnvironment}}"
      ];
      suffix = ["\\end{${cfg.latexEnvironment}}"];
      content = cfg.outOrdered "latex";
      predicate = x: "  " + x;
    };
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        "\n"
        cfg.latexWrapper.output;
    };
  };
}
