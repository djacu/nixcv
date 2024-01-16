{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    sections = lib.mkOption {
      description = "The sections of the CV.";
      type = types.nullOr (types.attrsOf (types.submoduleWith {
        modules = [./section.nix];
      }));
      default = null;
      visible = "shallow";
    };
    sep = lib.mkOption {
      description = "The separator between sections.";
      type = types.str;
      default = "\n\n";
      example = "\n";
    };
    order = lib.mkOption {
      description = "The order the sections are written.";
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
      plaintextFile = lib.mkOption {
        description = "The _out.plaintext as a file.";
        type = types.package;
        visible = false;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      latexFile = lib.mkOption {
        description = "The _out.latex as a file.";
        type = types.package;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out = {
      plaintext =
        lib.concatStringsSep
        cfg.sep
        (
          builtins.filter
          (x: x != "")
          (
            if (! builtins.isNull cfg.order)
            then
              (builtins.map)
              (y: cfg.sections."${y}"._out.plaintext or "")
              (cfg.order)
            else
              (builtins.map)
              (y: y._out.plaintext)
              (builtins.attrValues cfg.sections or "")
          )
        );
      plaintextFile = pkgs.writeTextFile {
        name = "nixcv-plaintext-doc";
        text = cfg._out.plaintext;
        destination = "/document.txt";
      };
      latex =
        lib.concatStringsSep
        cfg.sep
        (
          lib.flatten
          [
            "\\input{cv}"
            "\\begin{document}"
            (
              builtins.filter
              (x: x != "")
              (
                if (! builtins.isNull cfg.order)
                then
                  (builtins.map)
                  (y: cfg.sections."${y}"._out.latex or "")
                  (cfg.order)
                else
                  (builtins.map)
                  (y: y._out.latex)
                  (builtins.attrValues cfg.sections or "")
              )
            )
            "\\end{document}"
          ]
        );
      latexFile = pkgs.writeTextFile {
        name = "nixcv-latex-doc";
        text = cfg._out.latex;
        destination = "/document.tex";
      };
    };
  };
}
