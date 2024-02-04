{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    templates = lib.mkOption {
      description = "Template configuration for the LaTeX output.";
      #visible = "shallow";
      type = types.submodule {
        imports = [
          (
            import
            ../components/taggedContent.nix
            {
              submodules = [
                ../templates/templates.nix
              ];
            }
          )
        ];
      };
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
        lib.concatStringsSep
        "\n"
        (cfg.templates.outOrdered "latex");
    };
  };
}
