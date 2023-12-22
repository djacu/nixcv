{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    skills = lib.mkOption {
      description = "A list of skill categories.";
      type = types.nullOr (types.listOf (types.submoduleWith {
        modules = [
          ./skill.nix
        ];
      }));
      default = null;
      example = ''
      '';
    };
    sep = lib.mkOption {
      description = "The separator between the categories.";
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
      lib.concatStringsSep
      cfg.sep
      (
        builtins.map
        (x: x._outPlaintext)
        cfg.skills
      );
  };
}
