submodules: {
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  subsWith = types.submoduleWith {
    modules = submodules;
  };
in {
  options = {
    content = lib.mkOption {
      description = "Content for this submodule.";
      type = (
        types.either
        (types.listOf subsWith)
        (types.attrsOf subsWith)
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
      default =
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
    };
    outOrdered = lib.mkOption {
      description = "A function to get a specific ordered output.";
      type = types.raw;
      internal = true;
      visible = false;
      example = ''outOrdered "latex"'';
      default = out: (
        builtins.map
        (x: x._out.${out})
        cfg.contentsOrdered
      );
    };
  };
}
