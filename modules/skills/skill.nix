{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardListStringOut.nix
    ../components/latexWrapper.nix
    (
      import
      ../components/latexEnvironment.nix
      "skills"
    )
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["skill"];
      default = "skill";
      internal = true;
      description = "Type";
    };
    category = lib.mkOption {
      description = "A category name for the skills.";
      type = types.str;
      example = "Web Development";
    };
    keywords = lib.mkOption {
      description = "The skills for this category.";
      type = types.listOf types.str;
      example = ''
        [
          "HTML"
          "CSS"
          "JavaScript"
        ]
      '';
    };
  };
  config = {
    latexWrapper = {
      prefix = ["\\begin{${cfg.latexEnvironment}}"];
      suffix = ["\\end{${cfg.latexEnvironment}}"];
      content = (
        ["\\skillsCategory{${cfg.category}}"]
        ++ (
          builtins.map
          (x: "\\skillsKeyword{${x}}")
          cfg.keywords
        )
      );
      predicate = x: "  " + x;
    };
    _out = {
      plaintext = "";
      latex = cfg.latexWrapper.output;
    };
  };
}
