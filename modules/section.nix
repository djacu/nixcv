{
  lib,
  config,
  modules,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    header = lib.mkOption {
      description = "The section header.";
      type = types.nullOr types.str;
      default = null;
      example = "Experience";
    };
    headerFunc = lib.mkOption {
      description = "A string function applied to the header.";
      type = types.raw;
      default = lib.id;
      example = lib.literalExpression "lib.toUpper";
    };
    headerSep = lib.mkOption {
      description = "The separator between entries.";
      type = types.str;
      default = "\n\n";
      example = "\n";
    };
    content = lib.mkOption {
      description = "A list of module type.";
      type = types.nullOr (types.listOf (types.submoduleWith {
        inherit modules;
      }));
      default = null;
    };
    sep = lib.mkOption {
      description = "The separator between entries.";
      type = types.str;
      default = "\n\n";
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
      (
        if (builtins.isNull cfg.header)
        then ""
        else (cfg.headerFunc cfg.header) + cfg.headerSep
      )
      + (
        lib.concatStringsSep
        cfg.sep
        (
          builtins.map
          (x: x._outPlaintext)
          cfg.content
        )
      );
  };
}
