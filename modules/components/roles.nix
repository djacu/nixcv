{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    roles = lib.mkOption {
      description = "Your skills.";
      type = types.nullOr (
        types.attrsOf (types.submoduleWith {
          modules = [
            ./role.nix
          ];
        })
      );
      default = null;
    };
    sep = lib.mkOption {
      description = "The separator between roles.";
      type = types.str;
      default = "\n";
      example = "\n";
    };
    order = lib.mkOption {
      description = "The order the roles are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    _out.roles = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = let
    itemsOrdered = (
      if builtins.isNull cfg.order
      then builtins.attrValues cfg.roles
      else
        (
          builtins.map
          (elem: cfg.roles.${elem})
          cfg.order
        )
    );
  in {
    _out.roles = {
      plaintext = (
        utils.concatStringsSepFiltered
        cfg.sep
        ""
        (
          builtins.map
          (elem: elem._out.role.plaintext)
          itemsOrdered
        )
      );
    };
  };
}
