{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      experience = lib.mkOption {
        description = "An experience entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            [
              "empty"
              "basic"
            ]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [../experience.nix];
                  };
                }
            )
          );
        };
      };
    };
  };
  config = {
    nixcv = {
      experience = {
        empty = {};
        basic = {
          organization = "The NixOS Foundation";
          position = "Software Engineer";
          location.userStr = "Remote";
          url = "https://nixos.org/";
          summary = "A did Nix stuff.";
          highlights = "Stabilized flakes.";
          roles = [
            {
              role = "Nix Dev";
              responsibilities = [
                "Make new nix things."
                "Fix old nix things."
              ];
            }
          ];
        };
      };
    };
  };
}
