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
    profiles = lib.mkOption {
      description = "Your online profiles.";
      type = types.nullOr (
        types.attrsOf (types.submoduleWith {
          modules = [
            ./social.nix
          ];
        })
      );
      default = null;
    };
    sep = lib.mkOption {
      description = "The separator list elements.";
      type = types.str;
      default = "\n";
      example = "\n";
    };
    profileOrder = lib.mkOption {
      description = "The order the profiles are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    _out.profiles = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };

  config = let
    profilesOrdered = (
      if builtins.isNull cfg.profileOrder
      then builtins.attrValues cfg.profiles
      else
        (
          builtins.map
          (elem: cfg.profiles.${elem})
          cfg.profileOrder
        )
    );
  in {
    _out.profiles = {
      plaintext = (
        utils.concatStringsSepFiltered
        cfg.sep
        null
        (
          builtins.map
          (x: x._out.social.plaintext)
          profilesOrdered
        )
      );
      latex = (
        lib.concatMapStringsSep
        "\n"
        (x: x._out.social.latex)
        profilesOrdered
      );
    };
  };
}
