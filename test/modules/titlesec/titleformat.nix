{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      titleformat = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/titlesec/titleformat.nix
          [
            "minimal"
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      titleformat = rec {
        minimal = {
          command = ''\section'';
          format = ''\LARGE\bfseries'';
          label = "";
          sep = "0em";
          before-code = ''\MakeUppercase'';
        };
        basic =
          minimal
          // {
            shape = "hang";
            after-code = ''\color{black}\titlerule'';
          };
      };
    };
  };
}
