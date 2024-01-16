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
    ../components/standardStringOut.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["item"];
      default = "item";
      description = "Type";
      internal = true;
    };
    content = lib.mkOption {
      description = "A list item.";
      type = types.str;
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = "\\item {${cfg.applyFormat cfg.content}}";
    };
  };
}
