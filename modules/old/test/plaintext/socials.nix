{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        socials = lib.mkOption {
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
              ]
              (name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [../../components/socials.nix];
                  };
                })
            );
          };
        };
      };
    };
  };
  config = {
    nixcv = {
      test = {
        socials = {
          basic = {
            url = "https://djacu.dev/";
          };
        };
      };
    };
  };
}
