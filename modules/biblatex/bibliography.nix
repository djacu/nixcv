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
      type = types.enum ["bibliography"];
      default = "bibliography";
      description = "Type";
      internal = true;
    };

    heading = lib.mkOption {
      description = "This command defines bibliography headings. The name is an identifier to be passed to the heading option of \\printbibliography";
      type = types.enum [
        "bibliography"
        "subbibliography"
        "bibintoc"
        "subbibintoc"
        "bibnumbered"
        "subbibnumbered"
        "none"
        "biblist"
        "biblistintoc"
        "biblistnumbered"
      ];
      default = "subbibliography";
    };
    title = lib.mkOption {
      description = "This option overrides the default title provided by the heading selected with the heading option, if supported by the heading definition.";
      type = types.nullOr types.str;
      default = null;
      example = "Talks";
    };
    keyword = lib.mkOption {
      description = "Print only entries whose keywords field includes `keyword`.";
      type = types.nullOr types.str;
      default = null;
      example = "talk";
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = let
        bibOptions =
          lib.concatStringsSep
          ", "
          (
            lib.flatten (
              builtins.map
              (opt: lib.optional (! builtins.isNull cfg.${opt}) "${opt}={${cfg.${opt}}}")
              [
                "heading"
                "title"
                "keyword"
              ]
            )
          );
      in "\\printbibliography[${bibOptions}]";
    };
  };
}
