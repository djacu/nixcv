{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    entryKey = lib.mkOption {
      type = types.str;
      description = "The entry key.";
    };
    optionalFields = {
      keywords = lib.mkOption {
        type = types.commas;
        description = "A separated list of keywords. These keywords are intended for the bibliography filters, they are usually not printed";
      };
    };
  };
}
