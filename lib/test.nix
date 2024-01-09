{lib}: let
  inherit (lib) types;
in {
  createTestType = modulePath: testnames:
    types.submodule {
      options = (
        lib.genAttrs
        testnames
        (
          name:
            lib.mkOption {
              type = types.submoduleWith {
                modules = [modulePath];
              };
            }
        )
      );
    };
}
