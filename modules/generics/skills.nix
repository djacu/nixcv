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
      type = lib.types.enum ["skills"];
      default = "skills";
      internal = true;
      description = "Type";
    };
    content = lib.mkOption {
      description = "Your skills.";
      type = (
        types.attrsOf (types.submoduleWith {
          modules = [
            ./skill.nix
          ];
        })
      );
    };

    order = lib.mkOption {
      description = "The order the skills are written.";
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
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.listOf types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out = let
      contentsOrdered =
        if builtins.isNull cfg.order
        then builtins.attrValues cfg.content
        else
          (
            builtins.map
            (elem: cfg.content.${elem})
            cfg.order
          );
      outOrdered = out: (
        builtins.map
        (x: x._out.${out})
        contentsOrdered
      );
      wrapLatex = input:
        lib.flatten (
          builtins.map
          (
            group:
              [
                "" # the skills environment needs an empty newline between environments for the formatting to look correct
                "\\begin{skillsEnv}"
              ]
              ++ group
              ++ [
                "\\end{skillsEnv}"
              ]
          )
          (
            builtins.map
            (
              group:
                builtins.map
                (
                  inner:
                    builtins.map
                    (elem: "  " + elem)
                    inner
                )
                (lib.intersperse ["\\columnbreak"] group)
            )
            (utils.reshape 2 input)
          )
        );
    in {
      plaintext = "";
      latex = wrapLatex (outOrdered "latex");
    };
  };
}
