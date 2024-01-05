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
            ./socials.nix
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
    order = lib.mkOption {
      description = "The order the profiles are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
    _outLatex = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };

  config = let
    profilesOrdered = (
      if builtins.isNull cfg.order
      then builtins.attrValues cfg.profiles
      else
        (
          builtins.map
          (elem: cfg.profiles.${elem})
          cfg.order
        )
    );
  in {
    _outPlaintext = (
      utils.concatStringsSepFiltered
      cfg.sep
      null
      (
        builtins.map
        (x: x._outPlaintext)
        profilesOrdered
      )
    );
    _outLatex = (
      lib.concatMapStringsSep
      "\n"
      (x: x._outLatex)
      profilesOrdered
    );
  };
}