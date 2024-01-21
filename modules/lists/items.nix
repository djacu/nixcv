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
    ../components/format.nix
    ../components/orderedContent.nix
    ../components/standardListStringOut.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["items"];
      default = "items";
      description = "Type";
      internal = true;
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex =
        builtins.map
        (x: "\\item {${cfg.applyFormat (stringsLib.escapeLatex x)}}")
        cfg.contentsOrdered;
    };
  };
}
