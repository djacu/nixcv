{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    references = lib.mkOption {
      description = "A list of references.";
      type = types.nullOr (types.listOf (types.submoduleWith {
        modules = [
          ./reference.nix
        ];
      }));
      default = null;
      example = ''
      '';
    };
    sep = lib.mkOption {
      description = "The separator between references.";
      type = types.str;
      default = "\n\n";
      example = "\n\n";
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
        cfg.references
      );
  };
}
