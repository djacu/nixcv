{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    format = lib.mkOption {
      description = "Formatting applied to the LaTeX output.";
      default = null;
      type = types.nullOr (types.submodule {
        options = {
          bold = lib.mkOption {
            description = "Make the text bold.";
            type = types.bool;
            default = false;
          };
          italic = lib.mkOption {
            description = "Make the text italic.";
            type = types.bool;
            default = false;
          };
          uppercase = lib.mkOption {
            description = "Make the text uppercase.";
            type = types.bool;
            default = false;
          };
          size = lib.mkOption {
            description = "Apply a size modifier to the text.";
            type = types.nullOr (types.enum [
              "tiny"
              "scriptsize"
              "footnotesize"
              "small"
              "normalsize"
              "large"
              "Large"
              "LARGE"
              "huge"
              "Huge"
            ]);
            default = null;
          };
        };
      });
    };
    applyFormat = lib.mkOption {
      description = "Function for applying the formatting style to the LaTeX output.";
      type = types.raw;
      internal = true;
      visible = false;
      default = text:
        if builtins.isNull cfg.format
        then text
        else let
          formatting = (
            (lib.optional (! builtins.isNull cfg.format.size) cfg.format.size)
            ++ (lib.optional cfg.format.bold "textbf")
            ++ (lib.optional cfg.format.italic "textit")
            ++ (lib.optional cfg.format.uppercase "uppercase")
          );
        in
          builtins.foldl'
          (acc: x: "\\${x}{${acc}}")
          text
          formatting;
    };
  };
}
