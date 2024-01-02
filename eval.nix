# nix-instantiate --eval eval.nix -A old | jq -r
# nix-instantiate --eval eval.nix -A test --strict --json | jq .
# nix eval -f eval.nix old --raw
# nix eval -f eval.nix test --json | jq .
# nix eval -f eval.nix examples.config.nixcv._outPlaintext | jq -r
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
  old = pkgs.lib.evalModules {
    modules = [
      ./schema.nix
      ./myInfo.nix
    ];
  };
  test-plaintext =
    (
      pkgs.lib.evalModules
      {
        modules = [
          ./modules/test/plaintext
        ];
      }
    )
    .config
    .nixcv
    .test;

  test-bibentry =
    (
      pkgs.lib.evalModules
      {
        modules = [
          ./modules/test/bibentry
        ];
      }
    )
    .config
    .nixcv
    .test;

  examples = pkgs.lib.evalModules {
    modules = [
      ({config, ...}: {config._module.args = {inherit pkgs;};})
      ./modules/nixcv.nix
      ./examples/basic.nix
    ];
  };
in {
  old = old.config.plaintext;
  test = {
    plaintext = (
      builtins.mapAttrs
      (
        moduleName: moduleValue: (
          pkgs.lib.mapAttrs'
          (testName: testValue: pkgs.lib.nameValuePair testName (testValue._outPlaintext))
          moduleValue
        )
      )
      test-plaintext
    );
    bibentry = (
      builtins.mapAttrs
      (
        moduleName: moduleValue: (
          pkgs.lib.mapAttrs'
          (testName: testValue: pkgs.lib.nameValuePair testName (testValue._outBibEntry))
          moduleValue
        )
      )
      test-bibentry
    );
  };
  inherit examples;
}
