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
        ./modules/templates/newenvironment.nix
        ./modules/templates/template.nix
      ];
    })
    .config
    .test
  )
)
