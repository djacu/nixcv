{lib, ...}: let
  inherit (lib) types;
in {
  options = {
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
        type = types.listOf types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };
}
