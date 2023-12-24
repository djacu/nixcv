{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        reference = lib.mkOption {
          description = "A reference entry.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../sections/reference.nix];
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
        reference = {
          basic = {
            name = "John Doe";
            organization = "The NixOS Foundation";
            phone = "123.456.7890";
            email = "jdoe@nixos.org";
          };
        };
      };
    };
  };
}
