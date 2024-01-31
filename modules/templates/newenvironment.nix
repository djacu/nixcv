{
  lib,
  options,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardStringOut.nix
  ];
  options = {
    type = lib.mkOption {
      type = types.enum ["newenvironment"];
      default = "newenvironment";
      description = "Type";
      internal = true;
    };
    name = lib.mkOption {
      type = types.str;
      description = "The name of this user-defined environment.";
      example = "boxed";
    };
    begin = lib.mkOption {
      type = types.str;
      description = ''LaTeX code executed when the environment starts (opens), i.e., when you write \begin{name}.'';
      example = ''
        \par\vspace{\baselineskip}\noindent%
        \textbf{Exercise}\begin{itshape}%
        \par\vspace{\baselineskip}\noindent\ignorespaces%
      '';
    };
    end = lib.mkOption {
      type = types.str;
      description = ''LaTeX code executed when the environment ends (closes); i.e., when you write \end{name}.'';
      example = ''
        \end{itshape}\ignorespacesafterend%
      '';
    };
  };

  config = {
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        "\n"
        (
          lib.flatten
          [
            ''\newenvironment{${cfg.name}}''
            "{% begin"
            (lib.optional (options.begin.isDefined) cfg.begin)
            "}%"
            "{% end"
            (lib.optional (options.begin.isDefined) cfg.end)
            "}%"
          ]
        );
    };
  };
}
