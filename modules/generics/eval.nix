let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
  itemlist = pkgs.lib.evalModules {
    modules = [
      ./section.nix
      ./example.nix
    ];
  };
in {
  inherit itemlist;
}
