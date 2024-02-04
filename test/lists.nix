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
        ./modules/lists/item.nix
        ./modules/lists/items.nix
        ./modules/lists/itemlist.nix
        ./modules/lists/profile.nix
      ];
    })
    .config
    .test
  )
)
