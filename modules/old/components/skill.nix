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
    type = lib.mkOption {
      type = lib.types.enum ["skill"];
      default = "skill";
      internal = true;
      description = "Type";
    };
    label = lib.mkOption {
      description = "A category name for the skills.";
      type = types.nullOr types.str;
      default = null;
      example = "Web Development";
    };
    level = lib.mkOption {
      description = "The skill category fluency.";
      type = types.nullOr types.str;
      default = null;
      example = "Master";
    };
    labelSep = lib.mkOption {
      description = "The separator between the `label` and `keywords`.";
      type = types.str;
      default = ": ";
      example = " - ";
    };
    keywordsSep = lib.mkOption {
      description = "The separator between `keywords`.";
      type = types.str;
      default = ", ";
    };
    keywords = lib.mkOption {
      description = "The skills for this category.";
      type = types.nullOr (types.listOf types.str);
      default = null;
      example = ''
        [
          "HTML"
          "CSS"
          "JavaScript"
        ]
      '';
    };
    _out.skill = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out.skill = {
      plaintext =
        (
          if (builtins.isNull cfg.label)
          then ""
          else (cfg.label + cfg.labelSep)
        )
        + (
          utils.concatStringsSepFiltered
          cfg.keywordsSep
          null
          cfg.keywords
        );
    };
  };
}
