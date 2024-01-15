{
  nixcv = {
    basic = {
      order = [
        "personal"
        "objective"
        "work-exp"
        "skillsSection"
        "referencesSection"
      ];
      content = {
        personal = import ./examplePersonal.nix;
        objective = import ./exampleParagraph.nix;
        work-exp = import ./exampleWorkExp.nix;
        skillsSection = import ./exampleSkillsSection.nix;
        referencesSection = import ./exampleReferences.nix;
      };
    };
  };
}
