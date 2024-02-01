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
    ../components/latexWrapper.nix
    (
      import
      ../components/taggedContent.nix
      {
        submodules = [
          ./itemlist.nix
          ./item.nix
          ./items.nix
          ./profile.nix
        ];
      }
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
    latexWrapper = {
      prefix = ["\\begin{${cfg.latexEnvironment}}"];
      suffix = ["\\end{${cfg.latexEnvironment}}"];
      content = cfg.outOrdered "latex";
      predicate = x: "  " + x;
    };
    _out = {
      plaintext = "";
      latex = cfg.latexWrapper.output;
    };
  };
}
