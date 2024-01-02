{
  lib,
  config,
  options,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["skills"];
      default = "skills";
      internal = true;
      description = "Type";
    };
    skills = lib.mkOption {
      description = "Your skills.";
      type = types.nullOr (
        types.attrsOf (types.submoduleWith {
          modules = [
            ../components/skill.nix
          ];
        })
      );
      default = null;
    };
    sep = lib.mkOption {
      description = "The separator between skills.";
      type = types.str;
      default = "\n";
      example = "\n";
    };

    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext =
      utils.concatStringsSepFiltered
      cfg.sep
      null
      (
        builtins.map
        (skill: skill._outPlaintext)
        (builtins.attrValues cfg.skills)
      );
  };
}
