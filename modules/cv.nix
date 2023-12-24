{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config.nixcv;

  sections = {
    experience = ./experience.nix;
    education = ./education.nix;
    volunteer = ./experience.nix;
    skills = ./skill.nix;
    references = ./reference.nix;
  };
in {
  options = {
    nixcv =
      (
        lib.mapAttrs'
        (
          name: value:
            lib.nameValuePair
            name
            (lib.mkOption {
              description = "The ${name} section.";
              type = types.submoduleWith {
                modules = [./section.nix];
              };
            })
        )
        sections
      )
      // {
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
      };
  };
  config = {
    nixcv =
      (
        lib.mapAttrs'
        (
          name: value:
            lib.nameValuePair
            name
            {
              _module.args = {modules = [value];};
              content = [];
            }
        )
        sections
      )
      // {
        _outPlaintext = let
          cfgSections = builtins.removeAttrs cfg ["sep" "_outPlaintext"];
        in
          lib.concatStringsSep
          cfg.sep
          (
            builtins.filter
            (x: x != "")
            (
              (builtins.map)
              (x: x._outPlaintext)
              (builtins.attrValues cfgSections)
            )
          );
      };
  };
}
