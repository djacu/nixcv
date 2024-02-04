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
    (
      import
      ../components/orderedSubsWithContent.nix
      [
        ./skill.nix
      ]
    )
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["skills"];
      default = "skills";
      internal = true;
      description = "Type";
    };
  };
  config = {
    latexWrapper = {
      /*
      skills is unusual in that we need to wrap pairs of skill modules in the
      environment to get the latex to render properly. So there is not a
      prefix or suffix but they are part of the predicate.
      */
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
        (utils.reshape 2 (cfg.outOrdered "latex"))
      );
      predicate = content:
        [
          /*
          The skills environment needs an empty newline between environments
          for the formatting to look correct.
          */
          ""
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
