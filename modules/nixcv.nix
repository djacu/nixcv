{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = lib.mkOption {
      description = "A CV.";
      type = types.attrsOf (
        types.submoduleWith {
          modules = [./cv.nix];
        }
      );
    };
  };
}
