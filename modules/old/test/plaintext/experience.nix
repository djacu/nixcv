{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
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
                      modules = [../../sections/experience.nix];
                    };
                  }
              )
            );
          };
        };
      };
    };
  };
  config = {
    nixcv = {
      test = {
        experience = {
          empty = {};
          basic = {
            organization = "The NixOS Foundation";
            position = "Software Engineer";
            location.userStr = "Remote";
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
  };
}
