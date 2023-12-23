{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
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
                    modules = [../reference.nix];
                  };
                }
            )
          );
        };
      };
      references = lib.mkOption {
        description = "A references entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            [
              "basic"
              "sep"
            ]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [../references.nix];
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
      reference = {
        basic = {
          name = "John Doe";
          organization = "The NixOS Foundation";
          phone = "123.456.7890";
          email = "jdoe@nixos.org";
        };
      };
      references = {
        basic = {
          references = [
            {
              name = "John Doe";
              organization = "The NixOS Foundation";
              phone = "123.456.7890";
              email = "johndoe@nixos.org";
            }
            {
              name = "Jane Doe";
              organization = "The NixOS Foundation";
              phone = "111.222.3333";
              email = "janedoe@nixos.org";
            }
          ];
        };
        sep = {
          references = [
            {
              name = "John Doe";
              organization = "The NixOS Foundation";
              phone = "123.456.7890";
              email = "johndoe@nixos.org";
            }
            {
              name = "Jane Doe";
              organization = "The NixOS Foundation";
              phone = "111.222.3333";
              email = "janedoe@nixos.org";
            }
          ];
          sep = "\n\n\n";
        };
      };
    };
  };
}
