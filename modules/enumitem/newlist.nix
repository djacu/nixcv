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
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["newlist"];
      default = "newlist";
      description = "Type";
      internal = true;
    };
    name = lib.mkOption {
      description = "The name of the new list.";
      type = types.str;
      example = "mylist";
    };
    parent = lib.mkOption {
      description = "The type the new list inherits from.";
      type = types.enum [
        "enumerate"
        "itemize"
        "description"
      ];
      example = "itemize";
    };
    maxDepth = lib.mkOption {
      description = "The maximum depth the list can recurse.";
      type = types.int;
      default = 5;
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        ""
        [
          ''\newlist''
          "{${cfg.name}}"
          "{${cfg.parent}}"
          "{${builtins.toString cfg.maxDepth}}"
        ];
    };
  };
}
