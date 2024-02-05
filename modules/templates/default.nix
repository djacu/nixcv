{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  modulesLib = import ../../lib/modules.nix {inherit lib;};
in {
  options = {
    templates = lib.mkOption {
      description = "Template configuration for the LaTeX output.";
      visible = "shallow";
      type = types.submodule ../templates/templates.nix;
    };
    _out = {
      templates = lib.mkOption {
        description = "This modules template output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };

  config = {
    _out = {
      templates =
        if (! builtins.isNull cfg.templates.templateFile)
        then builtins.readFile cfg.templates.templateFile
        else
          lib.concatStringsSep
          "\n\n"
          [
            cfg.templates.layout._out.latex
            (
              lib.concatStringsSep
              "\n\n"
              (cfg.templates.outOrdered "latex")
            )
          ];
    };
  };
}
