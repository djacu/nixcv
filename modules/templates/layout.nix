{
  lib,
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
      type = types.enum ["layout"];
      default = "layout";
      description = "Type";
      internal = true;
    };
    documentclass = lib.mkOption {
      description = "The name of the new list.";
      default = "article";
      type = types.enum [
        "article"
        "proc"
        "minimal"
        "report"
        "book"
        "slides"
        "memoir"
        "letter"
        "beamer"
      ];
    };
    textsize = lib.mkOption {
      description = "Sets the size of the main font in the document.";
      type = types.str;
      default = "10pt";
    };
    pagestyle = lib.mkOption {
      description = "Sets the headers and footers styles.";
      type = types.enum [
        "empty"
        "plain"
        "headings"
      ];
      default = "empty";
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = (
        lib.concatStringsSep
        "\n"
        [
          (
            lib.concatStringsSep
            ""
            [
              ''\documentclass''
              ''[''
              ''${cfg.textsize}''
              '']''
              ''{''
              ''${cfg.documentclass}''
              ''}''
            ]
          )
          ''\pagestyle{${cfg.pagestyle}}''
        ]
      );
    };
  };
}
