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
          ./address.nix
          ./date.nix
          ./dateRange.nix
          ./profiles.nix
          ./roles.nix
          ./skill.nix
          ./skills.nix
          ./social.nix
        ];
      })
      .config
      .test
    )
  );
}
