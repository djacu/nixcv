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
      ../components/taggedContent.nix
      {
        submodules = [
          ../lists/itemlist.nix
          ../text/text.nix
        ];
      }
    )
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["personal"];
      default = "personal";
      description = "Type";
      internal = true;
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = cfg.outOrdered "latex";
    };
  };
}
