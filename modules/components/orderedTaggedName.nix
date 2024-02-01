{
  name,
  submodules,
  ordered,
}: {
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  modulesLib = import ../../lib/modules.nix {inherit lib;};
  taggedSubs = modulesLib.pathsToTaggedSubmodules submodules;
in {
  options = {
    "${name}" = lib.mkOption {
      description = "Content for this submodule.";
      default = null;
      type = types.nullOr (
        types.either
        (types.listOf taggedSubs)
        (types.attrsOf taggedSubs)
      );
    };
    "${name}Order" = lib.mkOption {
      description = "The order in which the ${name} are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
      visible = ordered;
    };

    "${name}Ordered" = lib.mkOption {
      description = "The contents of this submodule in order.";
      type = types.listOf (types.attrsOf (types.anything));
      internal = true;
      visible = false;
    };
    "${name}OutOrdered" = lib.mkOption {
      description = "A function to get a specific ordered output.";
      type = types.raw;
      internal = true;
      visible = false;
      example = ''${name}OutOrdered "latex"'';
    };
  };

  config = {
    "${name}Ordered" =
      if builtins.isNull cfg."${name}"
      then []
      else if (builtins.typeOf cfg."${name}" == "list")
      then cfg."${name}"
      else if builtins.isNull cfg."${name}Order"
      then builtins.attrValues cfg."${name}"
      else
        (
          builtins.map
          (elem: cfg."${name}".${elem})
          cfg."${name}Order"
        );
    "${name}OutOrdered" = out:
      lib.flatten (
        builtins.map
        (x: x._out.${out})
        cfg."${name}Ordered"
      );
  };
}
