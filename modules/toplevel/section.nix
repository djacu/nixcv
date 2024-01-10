{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  modulesLib = import ../../lib/modules.nix {inherit lib;};
  sectionTypes = lib.listToAttrs (
    builtins.map
    (
      file:
        lib.nameValuePair
        (lib.removeSuffix ".nix" file)
        (types.submodule ../sections/${file})
    )
    (
      builtins.attrNames (builtins.readDir ../sections)
    )
  );
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
      type = types.nullOr (types.attrsOf (
        modulesLib.taggedSubmodules {
          types = sectionTypes;
        }
      ));
      default = null;
    };
    sep = lib.mkOption {
      description = "The separator between entries.";
      type = types.str;
      default = "\n\n";
      example = "\n";
    };
    _out = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out = {
      plaintext =
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
            (x: x._out.${x.type}.plaintext)
            (builtins.attrValues cfg.content)
          )
        );
      latex =
        (
          if (builtins.isNull cfg.header)
          then ""
          else "\\section{${cfg.headerFunc cfg.header}}\n\n"
        )
        + (
          lib.concatStringsSep
          "\n"
          (
            builtins.map
            (x: x._out.${x.type}.latex)
            (builtins.attrValues cfg.content)
          )
        );
    };
  };
}
