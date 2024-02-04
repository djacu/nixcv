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
      type = types.enum ["rawlatex"];
      default = "rawlatex";
      description = "Type";
      internal = true;
    };
    latex = lib.mkOption {
      type = types.str;
      description = "User-defined raw latex.";
      example = ''\pdfgentounicode=1'';
    };
  };

  config = {
    _out = {
      plaintext = "";
      latex = cfg.latex;
    };
  };
}
