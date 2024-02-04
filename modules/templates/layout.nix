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
    papersize = lib.mkOption {
      description = "Set paper/media size.";
      default = "letterpaper";
      type = types.enum [
        "a0paper"
        "a1paper"
        "a2paper"
        "a3paper"
        "a4paper"
        "a5paper"
        "a6paper"
        "b0paper"
        "b1paper"
        "b2paper"
        "b3paper"
        "b4paper"
        "b5paper"
        "b6paper"
        "c0paper"
        "c1paper"
        "c2paper"
        "c3paper"
        "c4paper"
        "c5paper"
        "c6paper"
        "b0j"
        "b1j"
        "b2j"
        "b3j"
        "b4j"
        "b5j"
        "b6j"
        "ansiapaper"
        "ansibpaper"
        "ansicpaper"
        "ansidpaper"
        "ansiepaper"
        "letterpaper"
        "executivepaper"
        "legalpaper"
      ];
    };
    textwidth = lib.mkOption {
      description = "The width of the text body.";
      type = types.str;
      default = "7in";
    };
    textheight = lib.mkOption {
      description = "The height of the text body.";
      type = types.str;
      default = "9in";
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
          (
            lib.concatStringsSep
            ""
            [
              ''\usepackage''
              ''[''
              (
                lib.concatStringsSep
                ","
                [
                  ''paper=${cfg.papersize}''
                  ''width=${cfg.textwidth}''
                  ''height=${cfg.textheight}''
                ]
              )
              '']''
              ''{geometry}''
            ]
          )
          ''\pagestyle{${cfg.pagestyle}}''
        ]
      );
    };
  };
}
