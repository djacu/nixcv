{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      experience = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/sections/experience.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      experience = {
        basic = {
          organization = "The NixOS Foundation";
          position = "Software Engineer";
          address.userStr = "Remote";
          url = "https://nixos.org/";
          summary = "A did Nix stuff.";
          highlights = "Stabilized flakes.";
          roles = {
            nix-dev = {
              role = "Nix Dev";
              responsibilities = [
                "Make new nix things."
                "Fix old nix things."
              ];
            };
          };
        };
      };
    };
  };
}
