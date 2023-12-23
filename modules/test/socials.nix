{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
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
                  modules = [../socials.nix];
                };
              })
          );
        };
      };
    };
  };
  config = {
    nixcv = {
      socials = {
        basic = {
          url = "https://djacu.dev/";
        };
      };
    };
  };
}
