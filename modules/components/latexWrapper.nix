{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    latexWrapper = lib.mkOption {
      description = "Submodules for wrapping LaTeX outputs.";
      type = (
        types.submodule {
          options = {
            prefix = lib.mkOption {
              description = "LaTeX to add before the main content.";
              type = types.listOf types.str;
              default = [];
            };
            suffix = lib.mkOption {
              description = "LaTeX to add after the main content.";
              type = types.listOf types.str;
              default = [];
            };
            predicate = lib.mkOption {
              description = "A function applied to every element of the input.";
              type = types.raw;
              default = lib.id;
            };
            content = lib.mkOption {
              description = "The main content to be wrapped.";
              type = types.listOf types.anything;
            };
            output = lib.mkOption {
              description = "The latex content wrapped.";
              type = types.listOf types.str;
              default = (
                lib.flatten
                [
                  (cfg.latexWrapper.prefix)
                  (
                    builtins.map
                    cfg.latexWrapper.predicate
                    cfg.latexWrapper.content
                  )
                  (cfg.latexWrapper.suffix)
                ]
              );
            };
          };
        }
      );
    };
  };
}
