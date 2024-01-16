{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        referenceSection = lib.mkOption {
          description = "A references entry.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "sep"
                "headerFunc"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../../section.nix];
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
        referenceSection = {
          basic = {
            header = "References";
            content = {
              john-doe = {
                type = "reference";
                name = "John Doe";
                organization = "The NixOS Foundation";
                phone = "123.456.7890";
                email = "johndoe@nixos.org";
              };
              jane-doe = {
                name = "Jane Doe";
                type = "reference";
                organization = "The NixOS Foundation";
                phone = "111.222.3333";
                email = "janedoe@nixos.org";
              };
            };
          };
          sep = {
            header = "References";
            content = {
              john-doe = {
                type = "reference";
                name = "John Doe";
                organization = "The NixOS Foundation";
                phone = "123.456.7890";
                email = "johndoe@nixos.org";
              };
              jane-doe = {
                name = "Jane Doe";
                type = "reference";
                organization = "The NixOS Foundation";
                phone = "111.222.3333";
                email = "janedoe@nixos.org";
              };
            };
            sep = "; ";
          };
          headerFunc = {
            header = "References";
            headerFunc = lib.toUpper;
            content = {
              john-doe = {
                type = "reference";
                name = "John Doe";
                organization = "The NixOS Foundation";
                phone = "123.456.7890";
                email = "johndoe@nixos.org";
              };
              jane-doe = {
                name = "Jane Doe";
                type = "reference";
                organization = "The NixOS Foundation";
                phone = "111.222.3333";
                email = "janedoe@nixos.org";
              };
            };
          };
        };
      };
    };
  };
}
