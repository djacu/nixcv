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
      type = types.enum ["packages"];
      default = "packages";
      description = "Type";
      internal = true;
    };
    package = lib.mkOption {
      type = types.str;
      description = "The LaTeX package to add.";
    };
    packageOptions = lib.mkOption {
      type = types.nullOr (types.listOf types.str);
      description = "Optional arguments for the package.";
      default = null;
    };
    latex = lib.mkOption {
      type = types.nullOr (types.either (types.str) (types.listOf types.str));
      description = "LaTeX that will follow the package import.";
      default = null;
      example = ''\pdfgentounicode=1'';
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex = (
        lib.concatStringsSep
        "\n"
        (
          lib.flatten
          [
            (
              lib.concatStringsSep
              ""
              (
                lib.flatten
                [
                  ''\usepackage''
                  (
                    if builtins.isNull cfg.packageOptions
                    then ""
                    else
                      (
                        "["
                        + (lib.concatStringsSep "," cfg.packageOptions)
                        + "]"
                      )
                  )
                  "{${cfg.package}}"
                ]
              )
            )
            (
              if builtins.isNull cfg.latex
              then []
              else cfg.latex
            )
          ]
        )
      );
    };
  };
}
