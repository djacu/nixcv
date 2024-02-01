{submodules}: {
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
    content = lib.mkOption {
      description = "Content for this submodule.";
      type = (
        types.either
        (types.listOf taggedSubs)
        (types.attrsOf taggedSubs)
      );
    };
    order = lib.mkOption {
      description = "The order in which the contents are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    contentsOrdered = lib.mkOption {
      description = "The contents of this submodule in order.";
      type = types.listOf (types.attrsOf (types.anything));
      internal = true;
      visible = false;
    };
    outOrdered = lib.mkOption {
      description = "A function to get a specific ordered output.";
      type = types.raw;
      internal = true;
      visible = false;
      example = ''outOrdered "latex"'';
    };
  };

  config = {
    contentsOrdered =
      if (builtins.typeOf cfg.content == "list")
      then cfg.content
      else if builtins.isNull cfg.order
      then builtins.attrValues cfg.content
      else
        (
          builtins.map
          (elem: cfg.content.${elem})
          cfg.order
        );
    outOrdered = out:
      lib.flatten (
        builtins.map
        (x: x._out.${out})
        cfg.contentsOrdered
      );
  };
}
