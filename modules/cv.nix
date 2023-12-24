{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  sections = [
    {
      name = "education";
      value = ./sections/education.nix;
    }
    {
      name = "experience";
      value = ./sections/experience.nix;
    }
    {
      name = "volunteer";
      value = ./sections/experience.nix;
    }
    {
      name = "skills";
      value = ./sections/skill.nix;
    }
    {
      name = "references";
      value = ./sections/reference.nix;
    }
  ];
in {
  options =
    (
      lib.mapAttrs'
      (
        name: value:
          lib.nameValuePair
          name
          (lib.mkOption {
            description = "The ${name} section.";
            type = types.submoduleWith {
              modules = [./sections/section.nix];
            };
            visible = "shallow";
          })
      )
      (builtins.listToAttrs sections)
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
      order = lib.mkOption {
        description = "The order the sections are written.";
        type = types.listOf types.str;
        default = (
          builtins.map
          (x: x.name)
          sections
        );
      };
    };
  config =
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
      (builtins.listToAttrs sections)
    )
    // {
      _outPlaintext =
        lib.concatStringsSep
        cfg.sep
        (
          builtins.filter
          (x: x != "")
          (
            (builtins.map)
            (x: cfg."${x}"._outPlaintext)
            (cfg.order)
          )
        );
    };
}
