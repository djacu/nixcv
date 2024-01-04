{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      roles = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/components/roles.nix
          [
            "component"
            "parent"
          ]
        );
      };
    };
  };
  config = {
    test = {
      roles = rec {
        component = {
          roles = {
            web-dev = {
              role = "Web Developer";
              responsibilities = [
                "I make the website."
              ];
            };
            nix-dev = {
              role = "Nix Developer";
              roleSep = "\n-------------\n";
              respSep = "\n\n";
              responsibilities = [
                "I make the Nix."
                "I make the Modules."
                "I make the Flakes."
              ];
            };
            data-sci = {
              role = "Data Scientist";
              rolePrefix = "Role as a ";
              roleSuffix = ".";
              responsibilities = [
                "I make the data science."
              ];
            };
          };
        };
        parent =
          component
          // {
            sep = "\n\n";
            order = [
              "nix-dev"
              "web-dev"
              "data-sci"
            ];
          };
      };
    };
  };
}
