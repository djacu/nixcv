# nix-instantiate --eval eval.nix -A config.all --strict --json | jq .
# nix-instantiate --eval eval.nix -A config.plaintext | jq -r
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-22.11";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
in
  pkgs.lib.evalModules {
    modules = [
      ./schema.nix
      ./myInfo.nix
    ];
  }
