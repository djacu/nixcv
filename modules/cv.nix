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
        modules = [./sections/section.nix];
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
    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
    _outPlaintextFile = lib.mkOption {
      description = "The _outPlaintext as a file.";
      type = types.package;
      visible = false;
      readOnly = true;
    };
    order = lib.mkOption {
      description = "The order the sections are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };
  };
  config = {
    _outPlaintext =
      lib.concatStringsSep
      cfg.sep
      (
        builtins.filter
        (x: x != "")
        (
          if (! builtins.isNull cfg.order)
          then
            (builtins.map)
            (y: cfg.sections."${y}"._outPlaintext or "")
            (cfg.order)
          else
            (builtins.map)
            (y: y._outPlaintext)
            (builtins.attrValues cfg.sections or "")
        )
      );
    _outPlaintextFile = pkgs.writeText "my-resume" cfg._outPlaintext;
  };
}
