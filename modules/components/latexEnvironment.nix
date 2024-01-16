defaultEnv: {lib, ...}: let
  inherit (lib) types;
in {
  options = {
    latexEnvironment = lib.mkOption {
      description = "The environment name to use with the \\begin{} and \\end{} commands within LaTeX.";
      type = types.str;
      default = defaultEnv;
    };
  };
}
