{
  lib,
  config,
  options,
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
    skills = lib.mkOption {
      description = "Your skills.";
      type = types.nullOr (
        types.attrsOf (types.submoduleWith {
          modules = [
            ../components/skill.nix
          ];
        })
      );
      default = null;
    };
    sep = lib.mkOption {
      description = "The separator between skills.";
      type = types.str;
      default = "\n";
      example = "\n";
    };

    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
    _outLatex = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext =
      utils.concatStringsSepFiltered
      cfg.sep
      ""
      (
        builtins.map
        (skill: skill._outPlaintext)
        (builtins.attrValues cfg.skills)
      );
    _outLatex =
      (
        lib.concatStringsSep
        "\n"
        (
          # cut off the first newline
          lib.tail
          (
            lib.flatten
            (
              lib.imap0
              (
                idx: skill: let
                  keywordsList = (
                    builtins.map
                    (keyword: "    \\skillsKeyword{${keyword}}")
                    skill.keywords
                  );
                  skillEntry = [
                    "  \\begin{skills}"
                    "    \\skillsName{${skill.label}}"
                    keywordsList
                    "  \\end{skills}"
                  ];
                in (
                  if (lib.mod idx 2) == 0
                  then [
                    ""
                    "\\begin{skillsEnv}"
                    skillEntry
                  ]
                  else [
                    ""
                    "  \\columnbreak"
                    ""
                    skillEntry
                    "\\end{skillsEnv}"
                  ]
                )
              )
              (builtins.attrValues cfg.skills)
            )
          )
        )
      )
      + (
        # If there is an odd number of skills, we need to close the skillsEnv.
        lib.optionalString
        (lib.mod (builtins.length (builtins.attrValues cfg.skills)) 2 == 1)
        "\n\\end{skillsEnv}"
      );
  };
}
