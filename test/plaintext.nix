{lib}: (
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
        ./modules/components/address.nix
        ./modules/components/date.nix
        ./modules/components/dateRange.nix
        ./modules/components/profiles.nix
        ./modules/components/roles.nix
        ./modules/components/skill.nix
        ./modules/components/social.nix

        ./modules/sections/education.nix
        ./modules/sections/experience.nix
        ./modules/sections/namedlist.nix
        ./modules/sections/paragraphs.nix
        ./modules/sections/personal.nix
        ./modules/sections/reference.nix
        ./modules/sections/skills.nix
      ];
    })
    .config
    .test
  )
)
