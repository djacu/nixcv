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
      type = lib.types.enum ["text"];
      default = "text";
      description = "Type";
      internal = true;
    };
    content = lib.mkOption {
      description = "Plain text.";
      type = types.str;
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = "{${cfg.applyFormat cfg.content}}";
    };
  };
}
