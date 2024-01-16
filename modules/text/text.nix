{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ./format.nix
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
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = "{${cfg.applyFormat cfg.content}}";
    };
  };
}
