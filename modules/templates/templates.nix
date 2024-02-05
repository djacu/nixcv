{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  modulesLib = import ../../lib/modules.nix {inherit lib;};
in {
  imports = [
    (
      import
      ../components/taggedContent.nix
      {
        submodules = [
          ../templates/templatesContent.nix
        ];
      }
    )
  ];

  options = {
    layout = lib.mkOption {
      description = "Defines the document class and basic paper/text styles.";
      type = modulesLib.pathsToTaggedSubmodules [
        ../templates/layout.nix
      ];
      default = {
        type = "layout";
      };
    };

    templateFile = lib.mkOption {
      description = "A LaTeX template file. Will be used instead of any module settings.";
      type = types.nullOr types.path;
      default = null;
    };
  };
}
