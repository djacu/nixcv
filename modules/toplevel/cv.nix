{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    sections = lib.mkOption {
      description = "The sections of the CV.";
      type = types.nullOr (types.attrsOf (types.submoduleWith {
        modules = [./section.nix];
      }));
      default = null;
      visible = "shallow";
    };
    sep = lib.mkOption {
      description = "The separator between sections.";
      type = types.str;
      default = "\n\n";
      example = "\n";
    };
    order = lib.mkOption {
      description = "The order the sections are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };

    _out = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      plaintextFile = lib.mkOption {
        description = "The _out.plaintext as a file.";
        type = types.package;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out = {
      plaintext =
        lib.concatStringsSep
        cfg.sep
        (
          builtins.filter
          (x: x != "")
          (
            if (! builtins.isNull cfg.order)
            then
              (builtins.map)
              (y: cfg.sections."${y}"._out.plaintext or "")
              (cfg.order)
            else
              (builtins.map)
              (y: y._out.plaintext)
              (builtins.attrValues cfg.sections or "")
          )
        );
      plaintextFile = pkgs.writeText "my-resume" cfg._out.plaintext;
    };
  };
}
