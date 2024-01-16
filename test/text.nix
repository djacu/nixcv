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
        ./modules/text/paragraphs.nix
        ./modules/text/text.nix
      ];
    })
    .config
    .test
  )
)
