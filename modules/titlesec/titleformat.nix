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
      type = types.enum ["titleformat"];
      default = "titleformat";
      description = "Type";
      internal = true;
    };
    command = lib.mkOption {
      type = types.enum [
        ''\part''
        ''\chapter''
        ''\section''
        ''\subsection''
        ''\subsubsection''
        ''\paragraph''
        ''\subparagraph''
      ];
      description = "The sectioning command to be redefined.";
      example = lib.literalExpression "''\\section''";
    };
    shape = lib.mkOption {
      type = (
        types.enum [
          "hang"
          "block"
          "display"
          "runin"
          "leftmargin"
          "rightmargin"
          "drop"
          "wrap"
          "frame"
        ]
      );
      description = "Controls the basic distribution of elements in the title. See Chapter 3.1 of the titlesec package documentation for more information.";
      example = "hang";
    };
    format = lib.mkOption {
      type = types.str;
      default = "";
      description = "The format applied to the whole title—label and text.";
      example = lib.literalExpression "''\\LARGE\\bfseries''";
    };
    label = lib.mkOption {
      type = types.str;
      default = "";
      description = "The label to the left of the title.";
      example = lib.literalExpression "''Section \\thesection''";
    };
    sep = lib.mkOption {
      type = types.str;
      default = "0em";
      description = "The horizontal separation between label and title body and must be a length (it must not be empty).";
      example = "0.5ex";
    };
    before-code = lib.mkOption {
      type = types.str;
      default = "";
      description = "The code preceding the title body. The very last command can take an argument, which is the title text.";
      example = lib.literalExpression "''\\MakeUppercase''";
    };
    after-code = lib.mkOption {
      type = types.str;
      description = "The code following the title body.";
      example = lib.literalExpression "''\\color{black}\\titlerule''";
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
            ''\titleformat''
            "{${cfg.command}} % command"
            (lib.optional (options.shape.isDefined) "[${cfg.shape}] % shape")
            "{${cfg.format}} % format"
            "{${cfg.label}} % label"
            "{${cfg.sep}} % sep"
            "{${cfg.before-code}} % before-code"
            (lib.optional (options.after-code.isDefined) "[${cfg.after-code}] % after-code")
          ]
        );
    };
  };
}
