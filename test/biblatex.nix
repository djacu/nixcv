{lib}: (
  lib.mapAttrs
  (
    moduleName: moduleValue: (
      lib.mapAttrs
      (
        testName: testValue: (
          testValue._out
        )
      )
      moduleValue
    )
  )
  (
    (lib.evalModules {
      modules = [
        ./modules/biblatex/online.nix
        ./modules/biblatex/bibliography.nix
      ];
    })
    .config
    .test
  )
)
