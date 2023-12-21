# nix-instantiate --eval eval.nix -A config.all --strict --json | jq .
# nix-instantiate --eval eval.nix -A config.plaintext | jq -r
# nix eval -f eval.nix config.plaintext --raw
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
  eval = pkgs.lib.evalModules {
    modules = [
      ./modules/test.nix
    ];
  };
  evalConfig = eval.config.nixcv;
in (
  builtins.mapAttrs
  (
    moduleName: moduleValue: (
      pkgs.lib.mapAttrs'
      (testName: testValue: pkgs.lib.nameValuePair testName (testValue.out))
      moduleValue
    )
  )
  evalConfig
)
