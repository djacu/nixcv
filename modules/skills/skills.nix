{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  imports = [
    ../components/standardListStringOut.nix
    ../components/latexWrapper.nix
    (
      import
      ../components/latexEnvironment.nix
      "skillsEnv"
    )
  ];
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
  };
  config = let
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
  in {
    latexWrapper = {
      prefix = [];
      suffix = [];
      content = (
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
        (utils.reshape 2 (outOrdered "latex"))
      );
      predicate = content:
        [
          "" # the skills environment needs an empty newline between environments for the formatting to look correct
          "\\begin{${cfg.latexEnvironment}}"
        ]
        ++ content
        ++ [
          "\\end{${cfg.latexEnvironment}}"
        ];
    };
    _out = {
      plaintext = "";
      latex = cfg.latexWrapper.output;
    };
  };
}
