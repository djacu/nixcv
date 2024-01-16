{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    content = lib.mkOption {
      description = "Content for this submodule.";
      type = types.either (types.listOf types.str) (types.attrsOf types.str);
    };
    order = lib.mkOption {
      description = "The order in which the contents are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    contentsOrdered = lib.mkOption {
      description = "The contents of this submodule in order.";
      type = types.listOf types.str;
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
  };
}
