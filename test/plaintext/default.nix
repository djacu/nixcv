{lib}: {
  plaintext = (
    lib.mapAttrs
    (
      moduleName: moduleValue: (
        lib.mapAttrs
        (
          testName: testValue: (
            lib.mapAttrs'
            (
              outName: outValue:
                lib.nameValuePair
                "plaintext"
                outValue.plaintext
            )
            testValue._out
          )
        )
        moduleValue
      )
    )
    (
      (lib.evalModules {
        modules = [
          ./roles.nix
          ./address.nix
        ];
      })
      .config
      .test
    )
  );
}
