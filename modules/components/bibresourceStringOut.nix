{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    _out = {
      bibliography = lib.mkOption {
        description = "This modules bibliography output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };
}
