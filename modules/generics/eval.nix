let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
  section = pkgs.lib.evalModules {
    modules = [
      ./section.nix
      ./exampleSection.nix
    ];
  };
in {
  inherit section;
}
